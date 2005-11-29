Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVK2IqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVK2IqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVK2IqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 03:46:11 -0500
Received: from k1.dinoex.de ([80.237.153.113]:44285 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S1750896AbVK2IqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 03:46:10 -0500
From: Jochen Hein <jochen@jochen.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [linux.kernel] [2.6.15-rc2] cinergyT2: Unable to handle kernel paging request at virtual address ec6c10ec
References: <5dPxf-17g-37@gated-at.bofh.it> <5dPxf-17g-35@gated-at.bofh.it>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
Date: Tue, 29 Nov 2005 09:42:24 +0100
In-Reply-To: <5dPxf-17g-35@gated-at.bofh.it> (Johannes Stezenbach's message of
	"Mon, 28 Nov 2005 12:40:50 +0100")
Message-ID: <87mzjnj15b.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Milter: Spamilter (Reciever: k1.dinoex.de; Sender-ip: 80.237.153.113; Sender-helo: k1.dinoex.de;)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> writes:

> On Mon, Nov 28, 2005 at 09:32:07AM +0100, Jochen Hein wrote:
>> 
>> Sorry, I've forgotten to CC: you.
>
> I believe this is the input API change issue fixed in -git already.
> Please try 2.6.15-rc2-git6 or wait for -rc3.

I did compile and boot -git6 and that didn't have the message.  But I
didn't try to use the card yesterday.

Jochen

-- 
#include <~/.signature>: permission denied
