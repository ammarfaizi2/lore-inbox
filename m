Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTA1OxT>; Tue, 28 Jan 2003 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTA1Owk>; Tue, 28 Jan 2003 09:52:40 -0500
Received: from mail2.webart.de ([195.30.14.11]:5391 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265650AbTA1Ovz>;
	Tue, 28 Jan 2003 09:51:55 -0500
Message-ID: <398E93A81CC5D311901600A0C9F2928946938A@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'Stefan Reinauer'" <stepan@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: AW: Bootscreen
Date: Tue, 28 Jan 2003 15:51:58 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have a look at ftp.suse.com/pub/people/stepan/bootsplash/ - There you
> find kernel patches, user space utilities and such to display a
> bootsplash screen. You can either choose to have a picture put "behind"
> your text, or have a picture _instead_ of text. (triggerable with a 
> boot parameter so anybody is happy). And yes, it _does_ look cool to see
> your kernel messages scrolling up on a background of a slightly faded
> out penguin, looking like a water sign. ;-)
Janne has already posted that URL, but if you're the one who's written it,
thanks a lot! Looks like a pretty ultimate solution :-)

> My patch above includes a small and efficient jpeg decoder (8k), which
> allows you to read any jpg picture from an initrd.
There is still good in the world!

> It's not alien, and it does make sense. I, speaking for myself, know the
> kernel boot messages by heart and I don't expect them to change with the
> 2957596. bootup of my linux box. ;)
*g*

> Any comments?
Not anymore. ;-)

- Raphael
