Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbTBFWXr>; Thu, 6 Feb 2003 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbTBFWXq>; Thu, 6 Feb 2003 17:23:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15072 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267653AbTBFWXp>; Thu, 6 Feb 2003 17:23:45 -0500
Date: Thu, 06 Feb 2003 14:33:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: niteowl@intrinsity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 kernel bugs
Message-ID: <276580000.1044570790@[10.10.2.4]>
In-Reply-To: <1044573413.12098.19.camel@irongate.swansea.linux.org.uk>
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com> <267250000.1044565727@[10.10.2.4]> <1044573413.12098.19.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some fairly sickening stuff ... I'll log the following sections in bugzilla
>> If any brave volunteers for the others want to go ahead with the other
>> sections, and split the effort, would be much appreciated. Please mail
>> back to lkml that you're doing it ... and watch very carefully on newly
>> logged bugs for collisions ;-)
> 
> 2.4-ac fixes applied for :  (No name in the entry as I've not figured
> out who to credit yet)
> 
> o       Fix i2c_ack cris extra ";"
> o       Fix JSIOCSBTNMAP extra ";"
> o       Fix VIDIOCGTUNER on w9966
> o       Fix amd8111e_read_regs
> o       Fix smctr_load_node_addr
> o       Fix sym53c8xxx extra ";"
> o       Fix sym53c8xxx_2 extra ";"
> o       Fix cs46xx download area clear
> o       Fix hysdn bootup error handling
> o       Fix mtd mount error checks
> o       Fix dpt_i2o reset error paths
> o       Fix a jffs error path handler
> o       Fix es1371 error path on register
> o       Fix sscape operator precedence
> o       Fix copy counting in vrc5477 audio
> 
> Once the next -ac appears those should all drop into 2.5 if someone 
> wants to do the legwork

I'm happy to do whatever legwork is needed ... if you already have a 
seperate patch you could send my way for this stuff, would make it 
easier, if not, I'll go digging through your next release ... 

Thanks,

M.

