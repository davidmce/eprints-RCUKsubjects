$c->{plugins}{"Screen::EPMC::RCUKsubjects"}{params}{disable} = 0;
push @{$c->{browse_views}}, (
	{	
		id => "RCUKsubjects",
		menus => [
			{
			fields => ["RCUKsubjects"],
			hideempty => 1,
			},
			{
			fields => [ "date;res=year" ],
			reverse_order => 1,
			allow_null => 1,
			hideempty => 1,
			},
		],
		order => "creators_name/title",
		include => 1,
		variations => [
			"creators_name;first_letter",
			"type",
			"DEFAULT",
		],
	},
);

push @{$c->{fields}->{eprint}},
	{
		name => "RCUKsubjects",
		type => "subject",
		multiple => 0,
		top => "rcuksubjects",
		browes_link => "RCUKsubjects",
};

