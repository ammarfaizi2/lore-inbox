Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTA1NNE>; Tue, 28 Jan 2003 08:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTA1NNE>; Tue, 28 Jan 2003 08:13:04 -0500
Received: from mail2.webart.de ([195.30.14.11]:58122 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265351AbTA1NND>;
	Tue, 28 Jan 2003 08:13:03 -0500
Message-ID: <398E93A81CC5D311901600A0C9F2928946937F@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'John Bradford'" <john@grabjohn.com>, rob@r-morris.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Date: Tue, 28 Jan 2003 14:13:05 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Most of the machines I maintain are very seldom rebooted, but if someone

> > was to do a reboot, I would want them to be able to observe any errors
or 
> > other abnormal output from the boot-up process.
> 
> Agreed, for standard desktops and servers.
Well, I really don't know about you, but I for one reboot my desktop every
morning. Maybe this is a German attitude, but I generally consider it a
waste
of resources to have my workstation run during the night. For downloads and
the like, I got a headless server which does good power management in the
closet room. Besides, again: everyone [who is not a hacker] likes eyecandy.
I wouldn't normally say that if it wasn't about this discussion.

> There is no reason why the boot data can't go to a secondary display,
> a serial terminal, or a printer, or a speaker as a bleep code, etc.
Absolutely!

> In this case, boot data could be sent to a serial port, and the
> graphics card initialised by the boot loader to display a "Please
> wait, set top box booting up" screen, using a scan rate, which would
> be acceptable to the television.  In this case, we do not want the
> kernel to change the video card setup at all.
Yes! This is exactly what I want!
