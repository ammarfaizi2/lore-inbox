Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSC0Utt>; Wed, 27 Mar 2002 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSC0Utj>; Wed, 27 Mar 2002 15:49:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:27014 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S290797AbSC0UtU>;
	Wed, 27 Mar 2002 15:49:20 -0500
Date: Tue, 26 Mar 2002 19:01:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
Message-ID: <20020326190117.B324@toy.ucw.cz>
In-Reply-To: <200203252316.g2PNGD011116@numbat.Os2.Ami.Com.Au> <01c501c1d4874ce9180e0aa8c0@bridge> <20020326002128.L6223@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Linux doesn't support IDE hot swap at the drive level. Its basically
> > > > waiting people to want it enough to either fund it or go write the code
> > > > 
> > > 
> > > What needs to be done? How extensive is the surgery needed?
> > 
> 
> IDE isn't really meant to allow hot swap but it can be done.
> 
> As Jeremy says, electrically it is difficult to do it with a
> master+slave on one cable because you really must power down
> the interface (cable) and that would mean downing both devices.

But that's not a problem most times, right? Downing device on same
channel for 10 second it takes to plug it in should not be a problem.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

