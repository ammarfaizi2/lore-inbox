Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTA1OLK>; Tue, 28 Jan 2003 09:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTA1OLK>; Tue, 28 Jan 2003 09:11:10 -0500
Received: from mail2.webart.de ([195.30.14.11]:63756 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265469AbTA1OLH>;
	Tue, 28 Jan 2003 09:11:07 -0500
Message-ID: <398E93A81CC5D311901600A0C9F29289469380@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'Robert Morris'" <rob@r-morris.co.uk>, John Bradford <john@grabjohn.com>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>, linux-kernel@vger.kernel.org
Subject: AW: Bootscreen
Date: Tue, 28 Jan 2003 15:11:10 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree that it may be less inappropriate for certain specialised 
> applications, such as the one you suggested, but Raphael made specific 
> reference to Windows and Mac OS, which implies desktop use.
Indeed, I'm looking at desktop usage.

> I am totally fed up with the quest to make Linux into as close to a copy 
> of Windows as possible.
See, if there was no Windows, and no MacOS, and I'd see Linux boot...
...don't you think I'd still say -at some point- "Gee, these text messages
are so geeky. I'd like to have a cute picture shown while booting"? I mean,
really. Can we get rid of the "stupid guy who's trying to clone Windows"
dogma, please?

> OK, but in this case you would have problems with BIOS output etc. If you 
> left Linux alone, but fixed the BIOS to output at the required 
> frequencies, it would work - and using the quiet option, together with 
> appropriate output from the init scripts (which would presuambly be 
> heavily customised, in such an application) would yield a similar result.
I don't know about any TV applications. In my very case, the BIOS doesn't
do anything wrong. (Besides: there's also LinuxBIOS, which can also display
a cute picture, iirc). I have a bootloader, which puts a nice picture on
the screen. And I want that picture to remain there until X is running.
That's all. In actual fact, I'm really frugal.

> Wait screen, then just hangs", which would then require an engineer visit,
> as opposed to, for example, "it says Obtaining IP Address... then hangs"  
I do have a solution for that. Just make the image 640x440 instead 640x480,
and have the initscripts output on one of the lower lines only, always over-
writing the previous message. That way, the support engineer would know
what's
going wrong and you'd still have a cute picture.
