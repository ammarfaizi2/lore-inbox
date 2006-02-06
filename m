Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWBFSsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWBFSsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBFSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:48:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38123 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932155AbWBFSsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:48:07 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pavel Machek <pavel@ucw.cz>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
In-Reply-To: <200602061543.42174.nigel@suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602061402.54486.nigel@suspend2.net>
	 <1139200499.2791.210.camel@mindpipe>
	 <200602061543.42174.nigel@suspend2.net>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 13:48:01 -0500
Message-Id: <1139251682.2791.290.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 15:43 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Monday 06 February 2006 14:34, Lee Revell wrote:
> > On Mon, 2006-02-06 at 14:02 +1000, Nigel Cunningham wrote:
> > > (they now have to download extra
> > > libraries to use the splashscreen, which were not required with the
> > > bootsplash patch, and need to check whether an update to the userui
> > > code
> > > is required when updating the kernel)
> >
> > You could have avoided this problem by keeping the userspace<->kernel
> > interface stable.
> 
> True, but sometimes you need to make changes that do modify the interface. 
> If the interface involves more functionality, this will happen more 
> frequently.

Well, all I can say is, it should have been obvious that putting a
themeable UI in the kernel would not fly.

Lee

