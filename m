Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVKPWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVKPWFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVKPWFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:05:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61322 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030522AbVKPWFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:05:17 -0500
Date: Wed, 16 Nov 2005 23:05:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Greg KH <greg@kroah.com>, "Gross, Mark" <mark.gross@intel.com>,
       Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116220500.GF12505@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132172445.25230.73.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please, everyone realize that Nigel's code is not going to be merged
> > into mainline as it is today.  He knows it, and everyone else involved
> > knows it.  Nigel also knows the proper procedure for getting his changes
> > into mainline, if he so desires, as we all sat in a room last July and
> > discussed this (lwn.net has a summary somewhere about it too...)
> 
> Do you mean "as it was in July"? I haven't been sitting on my hands
> since July :)  My wife will testify to that!
...
> I've also split the one patch that most people see into what is
> currently about 225 smaller patches, each adding only one small part, am
> writing descriptions for them all and am preparing to build a git tree
> from it.

I'm not sure that gets suspend2 any closer to merging. 225 small
patches is still awful lot of code :-(. Now... if something can be
done in userspace, it probably should. And I'm trying to show that
suspend2 functionality can indeed be done in userspace.

So... to get 225 patches in, you'll need to explain that
userland-swsusp can't work. If you can do that, please be nice and do
it soon, so that I don't waste too much time on userland-swsusp.

								Pavel
-- 
Thanks, Sharp!
