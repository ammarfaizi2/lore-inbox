Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVLBNNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLBNNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 08:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVLBNNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 08:13:32 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:36284 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbVLBNNb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 08:13:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=clLBNF0AEw2acxPPqlDfvZmCLhHxUROOMNDwJLwHEa/dAcZZLtfp54IxTjV8PGWFeKeyPqYXsNsQmG6s1jfQZxc8Di4ypNS0F6Wca5sfVdKzeLkVs6GnHPJhZyGT0PwwiTpyRrkrqt1kunSo4etq0S9F+8KjJbeuqvPLfzq8s7g=
Message-ID: <ee0ae26a0512020513x6a9502aex@mail.gmail.com>
Date: Fri, 2 Dec 2005 22:13:29 +0900
From: Yanggun <yang.geum.seok@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.14 + SATAII150 TX2Plus does not recognize
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4390451F.9020903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>
	 <43902A52.9040909@gmail.com>
	 <ee0ae26a0512020436w2c000a5dq@mail.gmail.com>
	 <4390451F.9020903@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help :)

2005/12/2, Tejun Heo <htejun@gmail.com>:
> Yanggun wrote:
> > thanks.
> >
> > but sata_promise driver not seem to support hot-swap. As following
> > message is said, it becomes block. Even if use irqpoll option, result
> > is same.
> >
> > I want to use hot-swap.
> >
>
> Yeap, the standard doesn't support hot-swap yet.  I think either you
> gotta stay with 2.6.13 for the time being or wait for promise to update
> their driver.
>
> --
> tejun
>
