Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTLCRqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLCRqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:46:13 -0500
Received: from k1.dinoex.de ([80.237.200.138]:39917 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S264272AbTLCRqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:46:09 -0500
To: Ian Hastie <ianh@iahastie.clara.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] Missing L2-cache after warm boot
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <87ptf8bpnd.fsf@echidna.jochen.org>
	<200312020300.13067.ianh@iahastie.local.net>
	<878ylvjqpv.fsf@echidna.jochen.org>
	<200312031710.43786.ianh@iahastie.local.net>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Wed, 03 Dec 2003 18:37:11 +0100
In-Reply-To: <200312031710.43786.ianh@iahastie.local.net> (Ian Hastie's
 message of "Wed, 3 Dec 2003 17:10:42 +0000")
Message-ID: <871xrl4xbs.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Hastie <ianh@iahastie.clara.net> writes:

> No faster machine to compile on?  

An Mini-ITX with 550MHz isn't that much faster (but very quiet).

> Still think this isn't a kernel problem anyway.

That's my current guess too.  

>> For now the system seems to be fine, even when starting from Win2k via
>> BIOS reboot.  Hmpf.
>
> Annoying.  Can you think of anything you might have done with Windows 2000, eg 
> programme run or device used, that you haven't done when testing?

I won't have time this week, maybe next.  What concerns my is that
-test11 locks the machine hard after an hour or so (nmi-watchdog
doesn't say anything), but 2.4 seems to be stable.  Since I need a
stable machine next week I'll stay with 2.4 for now and come back
later.

Jochen

-- 
#include <~/.signature>: permission denied
