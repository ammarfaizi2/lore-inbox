Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTADAMN>; Fri, 3 Jan 2003 19:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTADAMN>; Fri, 3 Jan 2003 19:12:13 -0500
Received: from mail5.intermedia.net ([206.40.48.155]:23814 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id <S267729AbTADAMM>; Fri, 3 Jan 2003 19:12:12 -0500
From: "Ranjeet Shetye" <ranjeet.shetye@zultys.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [STUPID] Best looking code to transfer to a t-shirt
Date: Fri, 3 Jan 2003 16:20:43 -0800
Message-ID: <001901c2b387$1ea1eb00$0100a8c0@zultys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20030103233927.GM29422@holomorphy.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I vote for "panic ()" in kernel/panic.c

The panic output makes my heart sink everytime single time.

If only the Linux kernel had something as heart-warming as FreeBSD's
"diediedie ()". :D

Ranjeet Shetye
Senior Software Engineer

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> William Lee Irwin III
> Sent: Friday, January 03, 2003 3:39 PM
> To: Maciej Soltysiak
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
> 
> 
> On Fri, Jan 03, 2003 at 02:25:09PM +0100, Maciej Soltysiak wrote:
> > I am in a t-shirt transfering frenzy and was wondering 
> which part of 
> > the kernel code it would be best to have on my t-shirt. I 
> was looking 
> > at my favourite: netfilter code, but it is to clean, short 
> and simple 
> > functions, no tons of pointers, no mallocs, no hex numbers, 
> too many 
> > defines used. I was looking for something terribly complicated and 
> > looking awesome to the eye. How about we have a poll of the most 
> > frightening pieces of the kernel ? What are your ideas?
> 
> sheer bulk:			include/asm-ia64/sn/sn2/shub_mmr.h
> most typedefs:			
> include/asm-ia64/sn/sn2/shub_mmr_t.h
> bizarre (and ugly) idiom:	fs/devfs/*.c
> just plain ugly:		arch/i386/kernel/cpu/mtrr/generic.c
> really crusty-looking:		drivers/char/*tty*.c
> terrifying ultra-legacyness:	drivers/ide/legacy/hd.c
> fishiness:			drivers/usb/serial/pl2303.c
> why so much code?:		drivers/char/dz.c
> highly cleanup-resistant:	mm/slab.c
> unusual preprocessor games:	kernel/cpufreq.c
> contrived inefficiency:		
> fs/proc/inode.c:proc_fill_super()
> 
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

