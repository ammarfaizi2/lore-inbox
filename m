Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTJTVp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJTVp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:45:58 -0400
Received: from k1.dinoex.de ([80.237.200.94]:55824 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S262791AbTJTVp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:45:57 -0400
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test8] might sleep
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <785F348679A4D5119A0C009027DE33C105CDB31A@mcoexc04.mlm.maxtor.com>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 20 Oct 2003 23:22:41 +0200
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB31A@mcoexc04.mlm.maxtor.com> (Eric
 Mudama's message of "Mon, 20 Oct 2003 14:23:00 -0600")
Message-ID: <87ad7v8uzi.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mudama, Eric" <eric_mudama@Maxtor.com> writes:

> I guess the obvious question is "what boot options are you passing your
> kernel?"

Kernel command line: BOOT_IMAGE=LinuxOLD ro root=306 acpi=off
pci=usepirqmask console=ttyS2,19200n8 console=tty0

Jochen

-- 
#include <~/.signature>: permission denied
