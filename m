Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274181AbRISUrP>; Wed, 19 Sep 2001 16:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274184AbRISUrG>; Wed, 19 Sep 2001 16:47:06 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:63501 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S274181AbRISUqu> convert rfc822-to-8bit; Wed, 19 Sep 2001 16:46:50 -0400
Message-ID: <200109192251110218.11CA7E22@scispor.dolphinics.no>
In-Reply-To: <Pine.LNX.4.30.0109191337280.27884-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0109191337280.27884-100000@anime.net>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Wed, 19 Sep 2001 22:51:11 +0200
From: "Simen Thoresen" <simen-tt@online.no>
To: goemon@anime.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 19 Sep 2001, Simen Thoresen wrote:
>> On my non-buggy(*) KT133A board with the 55th register set to 09 I get these results;
>
>AFAIK you want it 89 not 09
>
Why? by default it is '09' on my system, it does not experience any oops-problems, and the spec still reads it to be '00' and 'dont program'.

I'm now applying the patch and rebuilding the kernel to permanently zero it.

Yours,
-S
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


