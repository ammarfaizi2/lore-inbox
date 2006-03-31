Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCaXRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCaXRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWCaXRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:17:19 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:65421 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932124AbWCaXRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:17:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: Staircase test patch
Date: Sat, 1 Apr 2006 09:17:08 +1000
User-Agent: KMail/1.9.1
Cc: Thorsten Will <thor_w@arcor.de>, linux list <linux-kernel@vger.kernel.org>
References: <200603312307.58507.kernel@kolivas.org> <20060331213106.GA6905@lliwnetsroht.news.arcor.de>
In-Reply-To: <20060331213106.GA6905@lliwnetsroht.news.arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604010917.09413.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 07:31, Thorsten Will wrote:
> On Friday 31 March 2006 23:07 +1000, Con Kolivas wrote:
> >Hi Thorsten et al
>
> Hi, Con.
>
> >Thorsten could you please test to see if this fixes the problem for you?
>
> Oh boy, oh boy, oh boy.
>
> Against a bash loop:
> |# dd bs=1M count=2048 </dev/hdb >/dev/null
> |2048+0 records in
> |2048+0 records out
> |2147483648 bytes transferred in 35.497603 seconds (60496582 bytes/sec)
>
> Yes! Success! And the crowd goes wild! :-)
>
> I think you finally nailed it. Thank you so much!

No, thank _you_ for bringing it to my attention and testing :)

Cheers,
Con
