Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFXQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFXQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:27:23 -0400
Received: from [62.67.222.139] ([62.67.222.139]:31948 "EHLO kermit")
	by vger.kernel.org with ESMTP id S262202AbTFXQ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:27:15 -0400
Date: Tue, 24 Jun 2003 18:40:26 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Success stories, disappearing Oopses and ps/2 keyboard
Message-ID: <20030624164026.GA2934@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

Well, that masterpeiece of Software, the 2.5.7x series is now running on
all computers I got my hands on (all i386 and physically accessable, the
others will be treated later) :) 

I must say, it runs great, especially on servers that thing does not
crash more often than 2.4.x. Well indeed I saw an Oops on my Server with
2.4.x which I did not debug, I put 2.5.72-mm2 onto it :)

These Kernels (2.5.7x-mmx) did not give an Oops too me and died if
running (lvm1 -> lvm2 and such things). Simultaniously switching to
devfs was no Problem...

I got some freezes with 2.5.70-mm9 and 2.5.71-mmx which seem to have
disappeared, lets see...

However, there is only one Problem left for me, before this one can be
called 2.6.0: The keys on my PS/2 IBM Keyboard are bouncing very often!
I switched from an USB Logitech Keyboard back to my old school, clicking
PC-102 IBM Keyboard ATM and the Key bouncing was back immmediatly :(

Over ssh connections it is even more extreme, I don't know why.

Are there any approaches to debug or whatsoever that thing? I saw many
changes to the input layer on this mailing list since 2.5.70 so I gave
this one Kernel here another chance :) (see signature). I just wanted to
say, the Problem hasn't gone yet, not more, and keep on hacking this
great mastepiece of Kernel :-)

Regards, Konsti


-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 1:38, 18 users
