Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTBGSk3>; Fri, 7 Feb 2003 13:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTBGSk3>; Fri, 7 Feb 2003 13:40:29 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:60682 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266318AbTBGSk2>;
	Fri, 7 Feb 2003 13:40:28 -0500
To: Andrew Morton <akpm@digeo.com>, adam@yggdrasil.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mm9
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 07 Feb 2003 19:43:23 +0100
In-Reply-To: <20030207095004$5ef0@gated-at.bofh.it> (Andrew Morton's message
 of "Fri, 07 Feb 2003 10:50:04 +0100")
Message-ID: <87lm0sszhw.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <20030207095004$5ef0@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> . Adam's cleanup and cutdown of devfs has been put back in again.  We
>   really need devfs users to test this and to report, please.  (And not just
>   to me!  I'll only bounce it to Adam J.  Richter <adam@yggdrasil.com>
>   anyway)

Ok, I patched 2.5.59 with Adam's patch and it boots fine.  I miss the
file /dev/.devfsd - Debian uses that file to detect devfs and act
accordingly.  Still in the first minutes, I'll get back when Linus has
released 2.5.60 (I'll probably switch back to a stock kernel then).

Jochen

-- 
#include <~/.signature>: permission denied
