Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269124AbTBXEBL>; Sun, 23 Feb 2003 23:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269125AbTBXEBL>; Sun, 23 Feb 2003 23:01:11 -0500
Received: from [24.206.178.254] ([24.206.178.254]:44419 "EHLO
	mail.brianandsara.net") by vger.kernel.org with ESMTP
	id <S269124AbTBXEBK>; Sun, 23 Feb 2003 23:01:10 -0500
From: Brian Jackson <brian@mdrx.com>
To: Xinwen Fu <xinwenfu@cs.tamu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to force 10/100 speeds in Linux?
Date: Sun, 23 Feb 2003 22:09:54 -0600
User-Agent: KMail/1.5
References: <Pine.SOL.4.10.10302232124240.17919-100000@dogbert>
In-Reply-To: <Pine.SOL.4.10.10302232124240.17919-100000@dogbert>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302232209.54857.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mii-tool

it's part of net-tools, HTH

--Brian


On Sunday 23 February 2003 09:30 pm, Xinwen Fu wrote:
> Hi,
> 	My Linux (Redhat 7.2) box has two network cards with built-in
> drivers in OS's kernel. One card is 10/100 netgear, and the other is
> 10/100 cnet.
>
> 	How can I force the speeds of the two cards at 10Mbps or 100Mbps?
> Where can I find the parameter list to do such forcing?
>
> 	Thanks!
>
> Xinwen Fu
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

