Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRIQRPG>; Mon, 17 Sep 2001 13:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271918AbRIQRO4>; Mon, 17 Sep 2001 13:14:56 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:47623 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271906AbRIQROt>; Mon, 17 Sep 2001 13:14:49 -0400
Message-ID: <3BA62FA0.F9700EFE@zip.com.au>
Date: Mon, 17 Sep 2001 10:15:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: Juan <piernas@ditec.um.es>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 journal on its own device?
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es> <E15j19N-0006Gh-00@mrvdom03.schlund.de> <3BA62575.E14C5808@ditec.um.es>,
		<3BA62575.E14C5808@ditec.um.es> <E15j1RG-00082a-00@mrvdom03.schlund.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> 
> > But the problem is that I need to use Linux 2.2.19, and the latest Ext3
> > version for that kernel is 0.0.7a, isn't it?.
> 
> good point. I am not sure if ext3 is still maintained for linux 2.2, but I
> doubt it. Andrew or Stephen should be able to answer this question.

Stephen is actively maintaining ext3 for the 2.2 kernels, but
it is definitely in "maintenance mode".

> But with 0.0.7a it is not possible to have an external journal.
> 

That's true.

-
