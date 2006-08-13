Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWHMVJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHMVJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHMVJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:09:16 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:47051 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751449AbWHMVJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:09:14 -0400
Date: Sun, 13 Aug 2006 23:09:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in kbuild.git for 2.6.19
Message-ID: <20060813210907.GA22409@mars.ravnborg.org>
References: <20060813194503.GA21736@mars.ravnborg.org> <20060813135426.8211204c.rdunlap@xenotime.net> <20060813135754.3c4a83a6.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813135754.3c4a83a6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:57:54PM -0700, Randy.Dunlap wrote:
> On Sun, 13 Aug 2006 13:54:26 -0700 Randy.Dunlap wrote:
> 
> > On Sun, 13 Aug 2006 21:45:03 +0200 Sam Ravnborg wrote:
> > 
> > > Just a quick intro to what is pending in kbuild.git/lxdialog.git
> > > for 2.6.19. And a short status too.
> > > 
> > > o try the new "make V=2" thing. It tells why a target got
> > > 	  rebuild. It is good to catch those "why the heck did
> > > kbuild rebuild that much after changing just a tine CONFIG_
> > > option".
> > 
> > Thanks, will use it.
> > 
> > > Jan Engelhardt:
> > >       kconfig: linguistic fixes for
> > > Documentation/kbuild/kconfig-language.txt kbuild: linguistic fixes
> > > for Documentation/kbuild/modules.txt kbuild: linguistic fixes for
> > > Documentation/kbuild/makefiles.txt
> > 
> > Were any of these used?
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115410865910922&w=2

No. I have your original mail queued but never got around to it.
A resubmit would be appreciated - with proper Signed-of-by:...

	Sam
