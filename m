Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278400AbRJSN1W>; Fri, 19 Oct 2001 09:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278404AbRJSN1M>; Fri, 19 Oct 2001 09:27:12 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:30475 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278400AbRJSN1D>; Fri, 19 Oct 2001 09:27:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrei Lahun <Uman@editec-lotteries.com>, linux-kernel@vger.kernel.org
Subject: Re: problems with I/O performance with 2.4.12-ac3
Date: Fri, 19 Oct 2001 09:27:35 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011019163058.1bb7c6f7.uman@chert>
In-Reply-To: <20011019163058.1bb7c6f7.uman@chert>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011019132707Z278400-17408+2377@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 10:30, Andrei Lahun wrote:
> hello.
>
> I did a bonnie++ tests with 2.4.13-pre3(+aa vm)
>  and 2.4.12-ac3(+Rick patch).
> And i found that ac kernel have a big problems here.
> With linux kernel i got 22 Mb/c for read 19 for write and
> with ac  12 for read and 11 for write (both with ext2)
> If i used ext3 with ac kernel results little bit better.
> What is the reason for such regression in ac kernel ?
> And yes of course i had udma for both test.
>
> Andrei.

You should give ide and drive chipset info.  This is not a problem seen by 
everyone using the ac3 kernel.  Mine for instance run just fine.  What 
settings did you use with bonnie++?  all of this is required info if someone 
wanted to look and see why you are getting those numbers.
