Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSHEURd>; Mon, 5 Aug 2002 16:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318874AbSHEURc>; Mon, 5 Aug 2002 16:17:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7950 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318869AbSHEURZ>;
	Mon, 5 Aug 2002 16:17:25 -0400
Message-ID: <3D4EDE2A.10508@mandrakesoft.com>
Date: Mon, 05 Aug 2002 16:20:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Lundell <linux@lundell-bros.com>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
References: <200208051906.g75J6d122986@www.hockin.org> <3D4ECF2B.2070000@mandrakesoft.com> <p05111a38b9748258869a@[207.213.214.37]>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> At 3:16 PM -0400 8/5/02, Jeff Garzik wrote:
> 
>> Tim Hockin wrote:
>>
>>> Is there a document describing the ethtool ioctl's which need to be
>>> implemented in each ethernet driver?
>>
>>
>> Unfortunately not.  There is a distinct lack of network driver docs at 
>> the moment...  The best documentation is looking at source code of 
>> drivers that implement the most ioctls.
> 
> 
> Is there a driver with anything like what you'd consider a canonical (or 
> at least exemplary) implementation of the ethtool ioctls?


tg3, 8139cp, and natsemi

