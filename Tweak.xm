@interface WAWeatherCityView
- (UILabel *)pageTemperature;
- (UIView *)pageHeaderView;
- (UILabel *)pageConditionDescription;
@property (strong) UIImageView *balls;
@end

%hook WAWeatherCityView

// hopefully that will work
// we cannot set it globally, because there are multiple WAWeatherCityView views
%property (strong) UIImageView *balls;

- (void)updateUIIncludingExtendedWeather:(_Bool)arg1 {
	%orig;

	if (self.balls) {
		[self.balls removeFromSuperview];
		self.balls = nil;
	}

	[[self pageTemperature] setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f]];

	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.zanehelton.hotasballs.plist"];

	BOOL isEnabled = [([prefs objectForKey:@"isEnabled"] ?: @(YES)) boolValue];
	BOOL isSingleBall = [([prefs objectForKey:@"isSingleBall"] ?: @(NO)) boolValue];
	if (!isEnabled) return;

	int hotAsBallsTemp = [([prefs objectForKey:@"hotAsBallsTemp"] ?: @(32)) intValue];
	int coldAsBallsTemp = [([prefs objectForKey:@"coldAsBallsTemp"] ?: @(-1)) intValue];
	NSString *hotAsBallsText = [prefs objectForKey:@"hotAsBallsText"] ?: @"It's hot as balls";
	NSString *coldAsBallsText = [prefs objectForKey:@"coldAsBallsText"] ?: @"It's cold as balls";

	NSString *tempString = [[[self pageTemperature] text] stringByReplacingOccurrencesOfString:@"°" withString:@""];
	int pageTemperature = [tempString intValue];

	HBLogDebug(@"pageTemperature = %i, hotAsBallsTemp = %i, coldAsBallsTemp = %i", pageTemperature, hotAsBallsTemp, coldAsBallsTemp);

	bool isItHotAsBalls = pageTemperature >= hotAsBallsTemp;
	bool isItColdAsBalls = pageTemperature <= coldAsBallsTemp;
	if (isItHotAsBalls || isItColdAsBalls) {

		NSString *pageConditionDescText;
		NSString *imagePath;
		if (isItHotAsBalls) {
			pageConditionDescText = [NSString stringWithFormat:@"%@ (%i°)", hotAsBallsText, pageTemperature];
			if (isSingleBall) {
				imagePath = @"/Library/Application Support/HotAsBalls/hot-ball.png";
			} else {
				imagePath = @"/Library/Application Support/HotAsBalls/hot-balls.png";
			}
		} else {
			pageConditionDescText = [NSString stringWithFormat:@"%@ (%i°)", coldAsBallsText, pageTemperature];
			if (isSingleBall) {
				imagePath = @"/Library/Application Support/HotAsBalls/cold-ball.png";
			} else {
				imagePath = @"/Library/Application Support/HotAsBalls/cold-balls.png";
			}
		}

		[[self pageTemperature] setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
		[[self pageConditionDescription] setFrame:CGRectMake([self pageConditionDescription].frame.origin.x,
															 [self pageConditionDescription].frame.origin.y,
														     [self pageConditionDescription].superview.frame.size.width,
														     [self pageConditionDescription].frame.size.height)];
		[[self pageConditionDescription] setText:pageConditionDescText];

		self.balls = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
		[self.balls setContentMode:UIViewContentModeScaleAspectFill];

		[self.balls setFrame:CGRectMake([self pageTemperature].frame.origin.x,
								   [self pageTemperature].frame.origin.y + 15,
								   [self pageTemperature].frame.size.width,
								   [self pageTemperature].frame.size.height)];
		[[self pageTemperature] addSubview:self.balls];

		[self.balls setTranslatesAutoresizingMaskIntoConstraints:NO];
		//NSDictionary *views = NSDictionaryOfVariableBindings(self.balls);	
		NSDictionary *viewsDictionary = @{@"balls": self.balls};

		[[self pageTemperature] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[balls]|"
																			  options:0
																			  metrics:nil
																				views:viewsDictionary]];
		[[self pageTemperature] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[balls]|"
																			  options:0
																			  metrics:nil
																				views:viewsDictionary]];
	}
}

%end
