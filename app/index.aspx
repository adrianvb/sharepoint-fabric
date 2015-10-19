<%@ Assembly Name="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"%> <%@ Page Language="C#" Inherits="Microsoft.SharePoint.WebPartPages.WikiEditPage" MasterPageFile="~masterurl/default.master"      MainContentID="PlaceHolderMain" %> <%@ Import Namespace="Microsoft.SharePoint.WebPartPages" %> <%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Import Namespace="Microsoft.SharePoint" %> <%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<asp:Content ContentPlaceHolderId="PlaceHolderPageTitle" runat="server">
	<SharePoint:ProjectProperty Property="Title" runat="server"/> - <SharePoint:ListItemProperty runat="server"/>
</asp:Content>
<asp:Content ContentPlaceHolderId="PlaceHolderPageImage" runat="server"><SharePoint:AlphaImage ID=onetidtpweb1 Src="/_layouts/15/images/wiki.png?rev=23" Width=145 Height=54 Alt="" Runat="server" /></asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
	<meta name="CollaborationServer" content="SharePoint Team Web Site" />
	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">

  <script type="text/javascript" src="vendor/jquery.js"></script>
  <script type="text/javascript" src="scripts/jquery.pivot.js"></script>
	<script type="text/javascript" src="scripts/jquery.personacard.js"></script>
	<script type="text/javascript" src="scripts/jquery.searchbox.js"></script>

	<script type="text/javascript" src="vendor/ShareCoffee.min.js"></script>

	<script type="text/javascript" src="vendor/angular.js"></script>
	<script type="text/javascript" src="vendor/angular-route.js"></script>
	<script type="text/javascript" src="vendor/angular-filter.min.js"></script>
	<script type="text/javascript" src="vendor/angular-sharepoint.js"></script>

	<script type="text/javascript" src="scripts/app.js"></script>

	<link rel="stylesheet" href="styles/app.css" />

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
    <link rel="stylesheet" href="vendor/fabric.css">
    <link rel="stylesheet" href="vendor/fabric.components.css">


		<!-- Application content goes here -->

		<div ng-app="servicesApp">

			<div ng-view></div>
		</div>
</asp:Content>
