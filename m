Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSIIKlV>; Mon, 9 Sep 2002 06:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSIIKlV>; Mon, 9 Sep 2002 06:41:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:39943 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316935AbSIIKlU>; Mon, 9 Sep 2002 06:41:20 -0400
Date: Mon, 9 Sep 2002 12:46:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: venom@sns.it, ahu@ds9a.nl, linux-kernel@vger.kernel.org
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
Message-ID: <20020909104604.GA26989@atrey.karlin.mff.cuni.cz>
References: <20020908225645.21341.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020908225645.21341.qmail@linuxmail.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > APM, and I pressed the shift key every few minutes,
> > > therefore no powersafe.
> > 
> > That still means APM bios calls when idle, right?
> 
> Yes, you are rigth.
> But again, with Byte Unix version 4.1 I got much
> more intersting result with no "strange" numbers,
> I tried that test few hours ago,.
> I know I can disable APM from both the kernel and the BIOS but I'd
> > > like to test the kernel I use in "daily" usage. What do you
> > > think about it? Do you suggest me to use a different
> > > configuration when I run the test?

Disable power managment. What you are doing is test of power managment
subsystem, I believe; that's okay but you did not label it as such.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
