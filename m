Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSFJXqq>; Mon, 10 Jun 2002 19:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSFJXqp>; Mon, 10 Jun 2002 19:46:45 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:17454 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S316567AbSFJXqp>; Mon, 10 Jun 2002 19:46:45 -0400
Message-ID: <3D053A4F.7010801@blue-labs.org>
Date: Mon, 10 Jun 2002 19:46:23 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Kai Henningsen <kaih@khms.westfalen.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
In-Reply-To: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com> <8QbwdDPmw-B@khms.westfalen.de> <3D051DAF.6020107@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 565; timestamp 2002-06-10 19:45:54, message serial number 5425
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ifconfig is "so yesterday" as it is, ip is incredibly more capable.  I 
would gently push ifconfig into the dungeons of time.

-d

Jeff Garzik wrote:

> Actually, networking is moving in the direction described --
> yes, as Linus points out, we will need the magic ioctl stuff for back 
> compat.
> But the main way to communicate with a net device is netlink, already 
> a chardev.  ifconfig actually should be updated to use netlink.


