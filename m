Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTEESdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTEESdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:33:06 -0400
Received: from k1.dinoex.de ([80.237.200.94]:43279 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S261204AbTEESdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:33:02 -0400
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Bug 663] New: "make modules" causes an error in mwavedd.h.
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <10610000.1052152626@[10.10.2.4]>
	<200305051938.12086.fsdeveloper@yahoo.de>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 05 May 2003 20:19:19 +0200
In-Reply-To: <200305051938.12086.fsdeveloper@yahoo.de> (Michael Buesch's
 message of "Mon, 5 May 2003 19:37:58 +0200")
Message-ID: <87wuh5w920.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> writes:

>> http://bugme.osdl.org/show_bug.cgi?id=663
>>
>>            Summary: "make modules" causes an error in mwavedd.h.
>>     Kernel Version: 2.5.69

> This patch fixes it:

Care to look at http://bugzilla.kernel.org/show_bug.cgi?id=185 too?
It would be nice to have a usable mwave for 2.6.

Jochen

-- 
#include <~/.signature>: permission denied
