Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbRLRRSK>; Tue, 18 Dec 2001 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284302AbRLRRRy>; Tue, 18 Dec 2001 12:17:54 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:28079 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S284289AbRLRRRb>; Tue, 18 Dec 2001 12:17:31 -0500
Message-ID: <3C1EEDFF.231F36B8@earthlink.net>
Date: Tue, 18 Dec 2001 02:19:27 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: VIA sound and SNDCTL_DSP_NONBLOCK error.....
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a ham radio operator who wishes to use the sound card for digital
comunications. However, my system has the VIA 82c686/ac97 sound. While I
can ofcourse make the sound work, playing/recording,etc, I cannot use it
with ham software.
Take twpsk31 for example, it compiles, but when trying to run it stops
on:
SNDCTL_DSP_NONBLOCK: illegal parameter.

On a system with a Sound Blaster Pro it runs fine, same Linux kernel,
etc.

I am no kernel expert. I have tried searching the web, found plenty of
hits saying the same problem, but no answer. I posted this to news
groups, no answer. I sent an email to what's  his name at SUSE, the
maintainer, no answer.

So, the questions
Why is the SNDCTL_DSP_NONBLOCK parameter not suppported in the driver?
Is it not supported do to hardware restrictions?
Is there a good web based source for information on the structure of the
sound drivers?

I really do not want to have to run Windows to operate digital modes.
Yes, they work fine using the via sound as a radio modem. Nor do I want
to have to buy another sound card just to do it.
Could this be the reason that more people don't use Linux. Having things
work on one system, but fail on another because of driver differences.
ie, working with a sound blaster, but not the via?

Jeff
piercejhsd009@earthlink.net
