Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313751AbSDPQOg>; Tue, 16 Apr 2002 12:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313754AbSDPQNk>; Tue, 16 Apr 2002 12:13:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50830 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313747AbSDPQMA>;
	Tue, 16 Apr 2002 12:12:00 -0400
Message-ID: <3CBC4D18.1090005@us.ibm.com>
Date: Tue, 16 Apr 2002 09:11:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ips driver compile problems
In-Reply-To: <E16xVOB-0000Ed-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Nope.. thats not what Documentation/DMA-mapping.txt says
> 
> It needs updating to use the pci DMA API. That also conveniently should
> put you close to having it work cross platform

Let me first point out, I have no official connection to the  writing of 
this driver.  It's a big company :)  I'm most interested in this because 
I have an old ServeRAID card at home.

I know that none of the real authors is actively working on fixing this. 
  Can this be accepted as a band-aid until the maintainers decide to 
maintain a 2.5 driver, or are we pushing authors to rewrite drivers 
which don't use the new DMA scheme?

-- 
Dave Hansen
haveblue@us.ibm.com

