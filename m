Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTLBTqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTLBTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:46:14 -0500
Received: from k1.dinoex.de ([80.237.200.138]:977 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S264334AbTLBTqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:46:12 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mfedyk@matchmail.com
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
	<20031201113300.7eb9bb7f.rddunlap@osdl.org>
	<87ekvnjr66.fsf@echidna.jochen.org>
	<20031202181421.GS1566@mis-mike-wstn.matchmail.com>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Tue, 02 Dec 2003 20:15:51 +0100
In-Reply-To: <20031202181421.GS1566@mis-mike-wstn.matchmail.com> (Mike
 Fedyk's message of "Tue, 2 Dec 2003 10:14:21 -0800")
Message-ID: <87znebxc7s.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Tue, Dec 02, 2003 at 02:16:33PM +0100, Jochen Hein wrote:
>> I've now restricted memory with mem=190m (has 196m installed).  I'll
>> keep investigating.
>
> What good does cutting 6MB off from use?

My old TP 600 had 96m installed, but due to BIOS-usage (mwave IIRC),
only 95m could be used for the os.  This is just a shot in the blue
now, but it didn't help anway.

Jochen

-- 
#include <~/.signature>: permission denied
