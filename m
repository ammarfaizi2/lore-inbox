Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUB0Kq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUB0Kq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:46:28 -0500
Received: from k1.dinoex.de ([80.237.200.138]:37118 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S261783AbUB0KqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:46:24 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Subject: [USB, SCANNER] scanner.ko removed, but documentation remains
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Fri, 27 Feb 2004 11:44:48 +0100
Message-ID: <87y8qols2n.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That was the ChangeLog to 2.6.3:

<greg@kroah.com>
        [PATCH] USB: remove scanner driver files.


I think that ./Documentation/usb/scanner.txt should be removed or
rewritten to point to libusb for scanner access.

Jochen

-- 
#include <~/.signature>: permission denied
