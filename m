Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTA1K4r>; Tue, 28 Jan 2003 05:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTA1K4r>; Tue, 28 Jan 2003 05:56:47 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:57011 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S265066AbTA1K4q>; Tue, 28 Jan 2003 05:56:46 -0500
Date: Tue, 28 Jan 2003 12:05:41 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
Subject: Re: Bootscreen
Message-ID: <20030128110541.GA5035@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <398E93A81CC5D311901600A0C9F29289469376@cubuss2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398E93A81CC5D311901600A0C9F29289469376@cubuss2>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Schmid, Tue, Jan 28, 2003 11:43:28 +0100:
> > I didn't mean use it with 2.5, i meant to port them to 2.4 ;)
> Ouch. Now that would be one hell of an exercise for me. 
> I'm only learning how single linked lists work these days.

we all trust in you

> > why not write a prog which does all the setup
> > and execs xinit at the end?
> I have that. It's in effect an /sbin/init replacement.

Oh.

> But this is also a question of attitude to me. Even if
> only a fake, I want Linux to be a *graphical* OS. *g*

put svgalib in kernel and export it's interface?

> > You can redirect the  output off the default
> > console. In this case you will see nothing.
> > Probably.
> I've just been asking this in another answer to LKML.
> Would mean the bootloader is the one reinitializing
> the screen, right?

not exactly. What you mean "reinitializing"?
It sets some video-mode and restores it afterwards.


