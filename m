Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271909AbRHVLIy>; Wed, 22 Aug 2001 07:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271984AbRHVLIo>; Wed, 22 Aug 2001 07:08:44 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:51461
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S271909AbRHVLI0>; Wed, 22 Aug 2001 07:08:26 -0400
Date: Wed, 22 Aug 2001 07:12:13 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Luca Montecchiani <m.luca@iname.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
Message-ID: <20010822071213.A9273@animx.eu.org>
In-Reply-To: <3B82B988.50DE308A@iname.com> <200108211957.f7LJvEt20846@vindaloo.ras.ucalgary.ca> <998430817.3139.41.camel@phantasy> <3B8350D3.CDE749E1@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3B8350D3.CDE749E1@iname.com>; from Luca Montecchiani on Wed, Aug 22, 2001 at 08:27:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > It also has nothing to do with Linux.  Some motherboard's TAG RAM do not
> > allow for caching more than xMB.
> 
> I'm just proposing to update the FAQ to help people like me 
> that thinking to gain speed doubling the system ram have seen
> a severe performance drop for certain task like compiling the 
> kernel .
> 
> Answer : 
> It has nothing to do with Linux, maybe your motherboard's TAG Ram
> do not allow for caching more than xMB.

The bios has something to do with that as well.  I have a dual pentium
machine at work that was really slow.  I looked in the bios and it has an
option to cache 64mb or 512mb.  speed up my kernel compiles (2.2.x) by about
12 minutes.  (took 20, after the change, it took about 8)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
