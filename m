Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRKHUGx>; Thu, 8 Nov 2001 15:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKHUGn>; Thu, 8 Nov 2001 15:06:43 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:29714 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277918AbRKHUGa>; Thu, 8 Nov 2001 15:06:30 -0500
Message-Id: <200111082006.fA8K6BY63324@aslan.scsiguy.com>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@online.fr>
cc: John Gluck <jgluckca@home.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support 
In-Reply-To: Your message of "Thu, 08 Nov 2001 20:37:18 +0100."
             <20011108203718.B505@online.fr> 
Date: Thu, 08 Nov 2001 13:06:11 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I also wonder why the reset delay is 15000 Msec. It used to be 5000
>> Msec. I've usually set it to that without nasty results. I just wonder
>> what the reasoning is behind such a long delay.
>
>This is a drawback of single driver for multiple cards. Good cards
>suffer to enable the driver to support bad ones.

This has nothing to do with the card the aic7xxx driver is accessing.

--
Justin
