Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSEHIWy>; Wed, 8 May 2002 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSEHIWw>; Wed, 8 May 2002 04:22:52 -0400
Received: from Expansa.sns.it ([192.167.206.189]:29450 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S311898AbSEHIWr>;
	Wed, 8 May 2002 04:22:47 -0400
Date: Wed, 8 May 2002 10:22:39 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Clifford White <ctwhite@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86 question: Can a process have > 3GB memory? 
In-Reply-To: <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com>
Message-ID: <Pine.LNX.4.44.0205081022110.25930-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you should be able to give to a single process till to 3.6 GB


On Tue, 7 May 2002, Clifford White wrote:

>
> We are working with a database that requires a large amount of memory
> allocated by a single process.
> This is on an Intel 32-bit platform.
> We'd like to go > 3GB of memory per process.
> Is this possible on a 32-bit machine? I have been reading the various
> 'highmem' discussions, but that's kernel page tables...
> Or is this a glibc issue, and not proper for a kernel-list question?
> Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
> Arch) page states that it's possible, but.....how?
>
> cliffw
> NUMA-Q
> Technical Guy
> 1-503-578-4306
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

