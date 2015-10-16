<%@ Assembly Name="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"%> <%@ Page Language="C#" Inherits="Microsoft.SharePoint.WebPartPages.WikiEditPage" MasterPageFile="~masterurl/default.master"      MainContentID="PlaceHolderMain" %> <%@ Import Namespace="Microsoft.SharePoint.WebPartPages" %> <%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Import Namespace="Microsoft.SharePoint" %> <%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<asp:Content ContentPlaceHolderId="PlaceHolderPageTitle" runat="server">
	<SharePoint:ProjectProperty Property="Title" runat="server"/> - <SharePoint:ListItemProperty runat="server"/>
</asp:Content>
<asp:Content ContentPlaceHolderId="PlaceHolderPageImage" runat="server"><SharePoint:AlphaImage ID=onetidtpweb1 Src="/_layouts/15/images/wiki.png?rev=23" Width=145 Height=54 Alt="" Runat="server" /></asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
	<meta name="CollaborationServer" content="SharePoint Team Web Site" />

  <script type="text/javascript" src="scripts/jquery.min.js"></script>
  <script type="text/javascript" src="scripts/jquery.pivot.js"></script>
	<script type="text/javascript" src="scripts/underscore-min.js"></script>

	<script type="text/javascript" src="scripts/backbone-min.js"></script>
	<script type="text/javascript" src="scripts/backbone-sharepoint.odata.js"></script>
	<script type="text/javascript" src="scripts/mustache.min.js"></script>

	<SharePoint:ScriptBlock runat="server">
		var navBarHelpOverrideKey = "WSSEndUser";
	</SharePoint:ScriptBlock>
	<SharePoint:RssLink runat="server" />
</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMiniConsole" runat="server">
	<SharePoint:FormComponent TemplateName="WikiMiniConsole" ControlMode="Display" runat="server" id="WikiMiniConsole"/>
</asp:Content>
<asp:Content ContentPlaceHolderId="PlaceHolderLeftActions" runat="server">
	<SharePoint:RecentChangesMenu runat="server" id="RecentChanges"/>
</asp:Content>
<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    <!-- Optionally include jQuery to use Fabric's Component jQuery plugins -->

    <!-- Fabric core -->
    <link rel="stylesheet" href="styles/fabric.min.css">
    <link rel="stylesheet" href="styles/fabric.components.min.css">

		<span id="browser-sync-binding"></span>
		<!-- Application content goes here -->
		<h1 class="ms-font-su">Why, hello, world.</h1>

		<div id="pivot-container"></div>

		<script id="pivot-template" type="x-tmpl-mustache">
			<ul class="ms-Pivot ms-Pivot--large">
				{{#groups}}
				<li class="ms-Pivot-link">{{.}}</li>
				{{/groups}}
				<li class="ms-Pivot-link ms-Pivot-link--overflow">
					<i class="ms-Pivot-ellipsis ms-Icon ms-Icon--ellipsis"></i>
				</li>
			</ul>
		</script>

		<div id="my-container"></div>

    <script>

			var Service = Backbone.SP.Item.extend({
				site: '/rechenzentrum/itsm',
				list: 'Services',
			});


			var ServiceList = Backbone.SP.List.extend({
				model: Service,

				groups: function() {
					console.log(_.uniq(this.pluck('Klasse0')));
					return _.uniq(this.pluck('Klasse0'));
				}
			});

			var Services = new ServiceList;

			var ServicesView = Backbone.View.extend({
    		tagName: "ul",
    		tpl:'{{#services}}<li>{{Title}}</li>{{/services}}',
		    render: function () {
						//console.log(this.collection.toJSON());
		        $(this.el).html(Mustache.render(this.tpl, { services: this.collection.toJSON() }));
		        $('#my-container').append(this.el);
		    },

				initialize: function() {
					console.log('view init');
					this.listenTo(Services, 'reset', this.render);
					this.listenTo(Services, 'all', this.render);
				}


		});

		var PivotView = Backbone.View.extend({
			tagName: "ul",
			tpl: $('#pivot-template').html(),
			render: function () {
					//console.log(this.collection.toJSON());
					$(this.el).html(Mustache.render(this.tpl, { groups: this.collection.groups() }));
					$('#pivot-container').append(this.el);
			},

			initialize: function() {
				console.log('view init');
				this.listenTo(Services, 'reset', this.render);
				this.listenTo(Services, 'all', this.render);
			}
		});

		var view = new ServicesView({ collection: Services });
		var pivotView = new PivotView({ collection: Services });

		console.log('fetching');
		Services.fetch()
    </script>



</asp:Content>
