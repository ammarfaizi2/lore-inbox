Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUAXIVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUAXIVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:21:16 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27372 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264442AbUAXIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:21:13 -0500
Date: Sat, 24 Jan 2004 01:21:11 -0700
From: Travis Morgan <lkml@bigfiber.net>
Subject: Re: ALSA vs. OSS
In-reply-to: <1074536486.5955.412.camel@castle.bigfiber.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <1074932471.11185.14.camel@castle.bigfiber.net>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1074532714.16759.4.camel@midux>
 <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
 <1074536486.5955.412.camel@castle.bigfiber.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, I figured out the below problem. I was able to set
XMMS' ALSA output to Wave instead of PCM and can now adjust the volume
as I could with OSS. Also, for gkrellm, the digital out volume is now
PCM2 rather than just PCM.

Now I can adjust my XMMS volume with my Playstation controller again! :)
The USB converter and a USB extension were two of the best purchases
I've made for my system.

Bus 002 Device 002: ID 6666:0667 Prototype product Vendor ID Smart Joy
PSX, PS-PC Smart JoyPad

Linux castle 2.6.2-rc1-mm2 #1 Fri Jan 23 23:37:56 MST 2004 i686 AMD
Athlon(tm) XP 2600+ AuthenticAMD GNU/Linux

Regards,
Travis M

On Mon, 2004-01-19 at 11:21, Travis Morgan wrote:
> So far I sort of tend to agree with you on OSS being better.
> 
> I have a soundblaster Live Value card. I can no longer control the
> output level through my digital out. With OSS my PCM volume used to
> affect both the headphone jack and the digital out. With ALSA it affects
> only the headphone jack.
> 
> I have loaded up alsamixer and played with every level in there and it
> doesn't seem possible to adjust the level anymore unless I adjust the
> wave volume. As a result I've been unable to get xmms or gkrellm to
> adjust the volume coming out of my stereo.
> 
> Now I like the idea of seperate volume controls, but this doesn't do
> that.
> 
> Regards,
> Travis M


