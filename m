Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSEGMVy>; Tue, 7 May 2002 08:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEGMVx>; Tue, 7 May 2002 08:21:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38665 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315423AbSEGMVx>; Tue, 7 May 2002 08:21:53 -0400
Message-ID: <3CD7B826.7000000@evision-ventures.com>
Date: Tue, 07 May 2002 13:19:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205071345110.32715-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Roman Zippel napisa?:
> Hi,
> 
> On Tue, 7 May 2002, Martin Dalecki wrote:
> 
> 
>>>>Then ide-pci.c is still compiled into the kernel. Why?
>>>
>>>Becouse the big tables there are subject to go.
>>
>>And at some point in time it will check whatever there is
>>request for any host chip support.
> 
> 
> Could you please then do the above change _after_ you have done this?

Well one question renames: Please name me one PCI based architecture
which contains IDE support and does not contain any special host chip
attached to the very same PCI bus as well.

