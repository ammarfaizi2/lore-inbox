Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSEVJNQ>; Wed, 22 May 2002 05:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSEVJNO>; Wed, 22 May 2002 05:13:14 -0400
Received: from host162-6.pool8173.interbusiness.it ([81.73.6.162]:7436 "EHLO
	shiva.lab.novalabs.net") by vger.kernel.org with ESMTP
	id <S316906AbSEVJMX>; Wed, 22 May 2002 05:12:23 -0400
Message-Id: <5.1.0.14.0.20020522104444.02ce7e00@shiva.intra.alphac.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 22 May 2002 10:47:30 +0200
To: linux-kernel@vger.kernel.org
From: Alessandro Morelli <alex@alphac.it>
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
In-Reply-To: <E17A9A1-0007hu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Does the ram survive memtest86 overnight with no errors logged if you boot
>memtest86 and just leave it ?

It did survive for a whole night (7pm through 8am).

Insmoding agpgart makes it fail after 35 seconds.

Sigh.

Good work to all,
Alex

