Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315378AbSEBTZ0>; Thu, 2 May 2002 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSEBTZZ>; Thu, 2 May 2002 15:25:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5392 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315378AbSEBTZX>;
	Thu, 2 May 2002 15:25:23 -0400
Message-ID: <3CD183DF.4000708@evision-ventures.com>
Date: Thu, 02 May 2002 20:22:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173Lzj-0004bc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>Yes I know. But my main point is that they maintain the
>>whole module symbol and dependency data entierly in user space
> 
> 
> Actually thats also incorrect as far as I can tell

They maintain a device driver tree there yes. But it's
a single directed tree there.

