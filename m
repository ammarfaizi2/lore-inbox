Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTDOBaF (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTDOBaF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:30:05 -0400
Received: from relay.pair.com ([209.68.1.20]:25616 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264027AbTDOBaE (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 21:30:04 -0400
X-pair-Authenticated: 68.40.145.213
Subject: Re: 2.4.20-ck5
From: Daniel Gryniewicz <dang@fprintf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org
In-Reply-To: <3E96D711.70404@comcast.net>
References: <3E96D711.70404@comcast.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050370913.1933.6.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 14 Apr 2003 21:41:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have had a problem with ck5.  I've been using the ckX kernel for
a while now, and they're great kernels.  ck4 was absolutely solid.  I've
been following the interactiveness changes in 2.5, although I don't use
it, with some interest, so I was really happy when you announced them in
ck5.  However, it broke my Evolution.  In large folders (such as LKML),
the current message jumps around randomly umong the unread messages when
I try and select the next unread message.  This does not happen with ck4
on an otherwise unchanged system (I use gentoo 1.4).  I remember
information about 2.5 breaking Evolution, but that was a long time
before these interactive fixes.  Here are my versions.  If there's
anything else you want, let me know.

Linux athena.fprintf.net 2.4.20-ck4 #2 Fri Feb 28 17:57:59 EST 2003 i686
AMD Athlon(tm) Processor AuthenticAMD GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.32
reiserfsprogs          3.6.4
pcmcia-cs              3.2.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         sr_mod ide-scsi ide-cd cdrom scsi_mod orinoco_cs
orinoco hermes snd-via82xx snd-ac97-codec snd-pcm snd-timer
snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore usbcore vfat
fat ds i82365 pcmcia_core rtc

-- 
Daniel Gryniewicz <dang@fprintf.net>

