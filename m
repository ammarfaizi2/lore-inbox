Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSFJXFo>; Mon, 10 Jun 2002 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFJXFn>; Mon, 10 Jun 2002 19:05:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316519AbSFJXFm>;
	Mon, 10 Jun 2002 19:05:42 -0400
Message-ID: <3D053010.9060409@mandrakesoft.com>
Date: Mon, 10 Jun 2002 19:02:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: Kai Henningsen <kaih@khms.westfalen.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
In-Reply-To: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com> <8QbwdDPmw-B@khms.westfalen.de> <3D051DAF.6020107@mandrakesoft.com> <200206110852.57442.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> On Tue, 11 Jun 2002 07:44, Jeff Garzik wrote:
> 
>>Actually, networking is moving in the direction described --
>>yes, as Linus points out, we will need the magic ioctl stuff for back
>>compat.
>>But the main way to communicate with a net device is netlink, already a
>>chardev.  ifconfig actually should be updated to use netlink.
> 
> Is there any documentation on the netlink API, beyond UTSL(iproute)?
> Reference would be good, but a tutorial would be ideal.


I don't know of any...  Alexey/DaveM/Jamal are probably the best people 
to ask.

	Jeff




