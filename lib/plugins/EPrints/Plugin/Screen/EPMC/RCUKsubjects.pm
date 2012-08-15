package EPrints::Plugin::Screen::EPMC::RCUKsubjects;

use strict;
use EPrints::Plugin::Screen::EPMC;
@ISA = ( 'EPrints::Plugin::Screen::EPMC' );

sub new
{
      my( $class, %params ) = @_;

      my $self = $class->SUPER::new( %params );

      $self->{actions} = [qw( enable disable )];
      $self->{disable} = 0; # always enabled, even in lib/plugins

      $self->{package_name} = "RCUKsubjects";

      return $self;
}

=item $screen->action_enable( [ SKIP_RELOAD ] )

Enable the L<EPrints::DataObj::EPM> for the current repository.

If SKIP_RELOAD is true will not reload the repository configuration.

=cut

sub action_enable
{
      my( $self, $skip_reload ) = @_;

      $self->SUPER::action_enable( $skip_reload );

      my $repo = $self->{repository};

      my $xml1 = '
<workflow xmlns="http://eprints.org/ep3/workflow" xmlns:epc="http://eprints.org/ep3/control">
        <stage name="subjects">
         <epc:if test="type = \'dataset\'">
        <component type="Field::Subject"><field ref="RCUKsubjects" required="yes" /></component>
        </epc:if>
        <component type="Field::Subject"><field ref="subjects" required="no" /></component>

        </stage>
</workflow>
';

=cut	my $xml2 = '
<?xml version="1.0" standalone="no"?>
<ul id="ep_tm_menu_browse" style="display:none;">
	<li>
              <a href="{$config{http_url}}/view/RCUK_subjects/">
                <epc:phrase ref="bin/generate_views:indextitleprefix"/>
                <epc:phrase ref="viewname_eprint_RCUK_subjects"/>
              </a>
	</li>
</ul>
';
=cut

      my $filename1 = $repo->config( "config_path" )."/workflows/eprint/default.xml";
=cut      my $filename2 = $repo->config( "config_path" )."/templates/default.xml";
=cut


	EPrints::XML::add_to_xml( $filename1, $xml1, $self->{package_name} );
=cut	EPrints::XML::add_to_xml( $filename2, $xmlx2, $self->{package_name} );
=cut
      $self->reload_config if !$skip_reload;
}

=item $screen->action_disable( [ SKIP_RELOAD ] )

Disable the L<EPrints::DataObj::EPM> for the current repository.

If SKIP_RELOAD is true will not reload the repository configuration.

=cut

sub action_disable
{
      my( $self, $skip_reload ) = @_;

      $self->SUPER::action_disable( $skip_reload );
      my $repo = $self->{repository};

      my $filename = $repo->config( "config_path" )."/workflows/eprint/default.xml";
 
      EPrints::XML::remove_package_from_xml( $filename, $self->{package_name} );
      
      $self->reload_config if !$skip_reload;

}

1;

