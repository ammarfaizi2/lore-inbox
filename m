Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTJZQPw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTJZQPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:15:52 -0500
Received: from k0.dinoex.de ([80.237.200.138]:38628 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S263271AbTJZQPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:15:51 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: matthias.andree@gmx.de
Subject: Re: Linux 2.4 <-> 2.6 compatibility
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
	<20031026150544.GJ15838@merlin.emma.line.org>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Sun, 26 Oct 2003 17:06:45 +0100
In-Reply-To: <20031026150544.GJ15838@merlin.emma.line.org> (Matthias
 Andree's message of "Sun, 26 Oct 2003 16:05:45 +0100")
Message-ID: <871xt0ouei.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> As 2.6 starts stabilizing, PLEASE try to synch up major components of
> 2.6 and 2.4 so that the same user space can be used for either version.
> It's fine with modutils and stuff, but when it comes to LVM, these 2.4
> and 2.6 versions are a problem.

Debian SID contains lvm10, lvm2 and lvm-common, which can be installed
together and work for both kernels.  Backport to woody was simple.

Jochen

-- 
#include <~/.signature>: permission denied
