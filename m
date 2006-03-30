Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWC3J0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWC3J0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWC3J0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:26:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12984 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932143AbWC3J0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:26:48 -0500
Date: Thu, 30 Mar 2006 11:26:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Mark Lord <lkml@rtr.ca>, suspend2-announce@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Message-ID: <20060330092627.GG8485@elf.ucw.cz>
References: <200603281601.22521.ncunningham@cyclades.com> <4429CC17.1030403@rtr.ca> <20060329091909.GA11438@elf.ucw.cz> <200603292050.33622.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603292050.33622.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 29-03-06 20:50:27, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 29 March 2006 19:19, Pavel Machek wrote:
> > On Út 28-03-06 18:51:51, Mark Lord wrote:
> > > Nigel Cunningham wrote:
> > > >Hi everyone.
> > > >
> > > >Suspend2, version 2.2.2 is now available from
> > > >
> > > >http://stage.suspend2.net/downloads/all/suspend2-2.2.2-for-2.6.16.tar.bz
> > > >2
> > >
> > > Wow!  Is this ever freaking fast!
> > > Try it folks.  Once you do, you'll never go back to the slow way!
> >
> > Please do try code at suspend.sf.net. It should be as fast and not
> > needing big kernel patch.
> 
> Don't bother suggesting that to x86_64 owners: compilation is currently broken  
> in vbetool/lrmi.c (at least).

It seems to work at least for some users. I do not have x86-64 machine
easily available, so someone else will have to fix that one.

(Also it should be possible to compile suspend without s2ram support,
avoiding the problem).
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
