Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282109AbRK1Jj1>; Wed, 28 Nov 2001 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282093AbRK1JjR>; Wed, 28 Nov 2001 04:39:17 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:59410 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S282108AbRK1JjE> convert rfc822-to-8bit; Wed, 28 Nov 2001 04:39:04 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Wouter van Bommel" <wvanbommel@jasongeo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Still problems with memory allocations
Date: Wed, 28 Nov 2001 10:32:42 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <002001c177ef$356f4be0$950000c0@jason.nl>
In-Reply-To: <002001c177ef$356f4be0$950000c0@jason.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E16916C-0002Do-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> X, but looks stable with the new kernel 2.4.10, however I ocassionally see
> the following message:
>
> __alloc_pages: 0-order allocation failed

2.4.10 was the first Kernel with a new VM. The problem is known and hopefully 
solved in later kernels. Unfortunately there is no update from SuSE. They are 
responsible if you want a full SuSE-like kernel. If you don't bother try 
2.4.13 or 2.4.16 from kernel.org.
Don' t use 2.4.15. 

greetings

Christian Bornträger
