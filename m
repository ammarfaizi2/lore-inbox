Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281670AbRKUINv>; Wed, 21 Nov 2001 03:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281671AbRKUINl>; Wed, 21 Nov 2001 03:13:41 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:6061 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281670AbRKUINe>;
	Wed, 21 Nov 2001 03:13:34 -0500
Message-ID: <3BFB625B.3000709@stesmi.com>
Date: Wed, 21 Nov 2001 09:14:19 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brian <hiryuu@envisiongames.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mixing 32- and 64-bit cards
In-Reply-To: <200111210600.fAL60kE11763@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> As mentioned in another thread, we are building a file server with 3ware 

> IDE RAID.
> 
> At the moment, we plan to get a 6800 (32-bit PCI).  If we add 7800's 
> (64-bit PCI) or some other 3ware card later, will the driver correctly 
> configure them all?  IOW, if I have


Sorry, I'm not answering your question but I do have a comment.

A month or so back 3ware discontinued _ALL_ their 3ware Escalades, the 
6xxx and the 7xxx, they have since then recieved so many mails that 
they've restarted development, support and production of them.

With one 'minor' issue, they're discontinuing their 6xxx (32bit) series 
of cards. So I would recommend getting the 64bit 7xxx series directly 
instead.

// Stefan


