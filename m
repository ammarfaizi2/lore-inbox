Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUDSVeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUDSVeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDSVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:34:11 -0400
Received: from node249-201.sim.db.erau.edu ([155.31.249.201]:28289 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261884AbUDSVeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:34:07 -0400
Subject: Re: How to make Linux route multicast traffic bi-directionly
	between multible subnets
From: John Pesce <pescej@sprl.db.erau.edu>
Reply-To: pescej@sprl.db.erau.edu
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40843363.4070903@backtobasicsmgmt.com>
References: <1082389059.1982.15.camel@inferno>
	 <20040419200739.GA3020@localhost>  <40843363.4070903@backtobasicsmgmt.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082410441.1971.27.camel@inferno>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Apr 2004 17:34:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2004-04-19 at 16:15, Kevin P. Fleming wrote:
> Jose Luis Domingo Lopez wrote:
> 
> > So, to summarize, your best bet is to get "mrouted" or something like
> > that, and have a look at the documentation bundled. You are quite right,
> > multicast routing documentation for Linux seems to be quite old, rather
> > short, and maybe out of date.
> 
> That it is, but if you use the mrouted source and patches from the 
> Debian distribution it's fairly easy to get a basic network working. It 
> took me a few days to get it all set up, but I now have a router that 
> routes multicast between local devices and two remotes over OpenVPN 
> tunnels. Setting up mrouted was actually pretty easy, once I figured out 
> that's what I needed and got the Debian patches so it would compile.

Currently we are running Redhat 9.0 and Suse 9.0 boxes with plans to
possibly move to Suse 9.1 boxes when the Suse 9.1 comes out with 2.6
kernel support.

I've seen several sites claiming to provide the elusive "mrouted".

Can you point me to a specific location for "the" mrouted demon you are
referring to ;)

Have you played with xorp.org? It claims to be a multicast capable
router?

Thanks. 

