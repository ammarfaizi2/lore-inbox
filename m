Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290020AbSAWURE>; Wed, 23 Jan 2002 15:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290022AbSAWUQs>; Wed, 23 Jan 2002 15:16:48 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:18749 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290020AbSAWUQc>; Wed, 23 Jan 2002 15:16:32 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 21:16:25 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123201626.2EDEF1458@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 18:15, Daniel Nofftz wrote:
> hi there!
>
[...]
>
> if the patch gets a good feedback, maybe it is something for the official
> kernel tree ?
>
> daniel

Hi Daniel & folks,

just tried your patch on my (diskless) asus a7v133 (kt133) with 1.2 GHz
Athlon. I normally had 14% base load spend in apmd-idled and a CPU temp.
of 45°C. After getting it to work, I see a base load of around 1% (mostly 
spend in artsd), but CPU is only 1°-2° less now :-( I hoped, it it
would be more). Nevertheless, it is a very important patch nowadays where
temperature is the last technical barrier, and energy saving an economic
necessity.

Many thanks and greetings from Berlin to Trier ;)
  Hans-Peter
