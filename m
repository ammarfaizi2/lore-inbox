Return-Path: <linux-kernel-owner+w=401wt.eu-S932354AbXAGClh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbXAGClh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbXAGClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:41:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354AbXAGClg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:41:36 -0500
Date: Sat, 6 Jan 2007 21:41:16 -0500
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Torsten Kaiser <tk13@bardioc.dyndns.org>, Olaf Hering <olaf@aepfle.de>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/2 v4] sysrq: showBlockedTasks is sysrq-W
Message-ID: <20070107024116.GA1905@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Torsten Kaiser <tk13@bardioc.dyndns.org>,
	Olaf Hering <olaf@aepfle.de>, lkml <linux-kernel@vger.kernel.org>,
	akpm <akpm@osdl.org>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net> <20070105193605.GA14592@aepfle.de> <20070106102531.29ce662c.randy.dunlap@oracle.com> <200701062019.29974.tk13@bardioc.dyndns.org> <20070106140424.2a4fa38b.randy.dunlap@oracle.com> <20070107000945.GA1533@redhat.com> <20070106183628.60670a1b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106183628.60670a1b.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 06:36:28PM -0800, Randy Dunlap wrote:
 > On Sat, 6 Jan 2007 19:09:45 -0500 Dave Jones wrote:
 > 
 > > On Sat, Jan 06, 2007 at 02:04:24PM -0800, Randy Dunlap wrote:
 > > 
 > >  > +	.help_msg	= "showBlockedTasks(W)",
 > > 
 > > Why not the same scheme as the existing help msgs..
 > 
 > Yes.  Thanks.
 > 
 > > shoWblockedtasks  ?
 > 
 > Would shoW-blocked-tasks be OK?

Works for me.

thanks,

		Dave

-- 
http://www.codemonkey.org.uk
