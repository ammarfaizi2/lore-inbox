Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKNUta>; Wed, 14 Nov 2001 15:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRKNUtM>; Wed, 14 Nov 2001 15:49:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56302 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277514AbRKNUs5>;
	Wed, 14 Nov 2001 15:48:57 -0500
Message-ID: <3BF2D8C7.6D344638@vnet.ibm.com>
Date: Wed, 14 Nov 2001 20:49:11 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.cx>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] arbitrary size memory allocator, memarea-2.4.15-D6
In-Reply-To: <Pine.LNX.4.21.0111131557511.12260-100000@Consulate.UFP.CX>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:
> 
> Hi Jeff.
> 
> > With bootmem you know that (for example) 100GB of physically
> > contiguous memory is likely to be available...
> 
> Please point me to where you found a machine with 100 Gigabytes of RAM
> as I could realy make use of that here...

Well as an example, the new IBM pSeries p690, and yes it does run Linux.

Will it be 100 Gig of physically contiguous memory? Not necessarily but it
certainly could be.

Now if it would only fit under my desk....

> Best wishes from Riley.

Regards,

Tom

-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
