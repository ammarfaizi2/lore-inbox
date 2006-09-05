Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWIEVvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWIEVvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWIEVvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39649 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751460AbWIEVvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:51:15 -0400
Date: Tue, 5 Sep 2006 14:50:49 -0700
From: Greg KH <greg@kroah.com>
To: maximilian attems <maks@sternwelten.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060905215049.GB21404@kroah.com>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de> <20060905124505.GE4868@baikonur.stro.at> <20060905185641.GA17950@kroah.com> <20060905190132.GG4868@baikonur.stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905190132.GG4868@baikonur.stro.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 09:01:32PM +0200, maximilian attems wrote:
> On Tue, Sep 05, 2006 at 11:56:41AM -0700, Greg KH wrote:
> > On Tue, Sep 05, 2006 at 02:45:05PM +0200, maximilian attems wrote:
> > > On Tue, Sep 05, 2006 at 02:26:56PM +0200, Olaf Hering wrote:
> > > > On Sun, Sep 03, Linus Torvalds wrote:
> > > > 
> > > > > 
> > > > > Things are definitely calming down, and while I'm not ready to call it a 
> > > > > final 2.6.18 yet, this migt be the last -rc.
> > > > 
> > > 
> > > there is a regression since 2.6.17 on some boxes:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=6875
> > > http://bugzilla.kernel.org/show_bug.cgi?id=6920
> > > 
> > > the attached patch is known to fix the regression:
> > > http://bugzilla.kernel.org/attachment.cgi?id=8798&action=view
> > 
> > The fix for this (your referenced patch) is already in 2.6.18-rc5.  Does
> > it not work properly for you?
> > 
> > thanks,
> > 
> > greg k-h
> 
> great that's why i didn't see it in latest -mm.
> not affected myself,
> but 2.6.17 + patch build for bug reporter works fine.
> 
> please consider it for next stable release.

Please forward it to the stable@kernel.org address then so it can be
applied there :)

thanks,

greg k-h
