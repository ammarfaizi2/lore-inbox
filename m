Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSFWONS>; Sun, 23 Jun 2002 10:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSFWONR>; Sun, 23 Jun 2002 10:13:17 -0400
Received: from static62-99-146-174.adsl.inode.at ([62.99.146.174]:32418 "EHLO
	silo.pitzeier.priv.at") by vger.kernel.org with ESMTP
	id <S317026AbSFWONN>; Sun, 23 Jun 2002 10:13:13 -0400
Reply-To: <oliver@linux-kernel.at>
From: "Oliver Pitzeier @ Home" <oliver@linux-kernel.at>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
       "'Jurriaan on Alpha'" <thunder7@xs4all.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.24 doesn't compile on Alpha
Date: Sun, 23 Jun 2002 16:11:28 +0200
Organization: linux kernel austria
Message-ID: <000901c21abf$e1a11060$1201a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020621192405.A749@jurassic.park.msu.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Fri, Jun 21, 2002 at 04:19:57PM +0200, Jurriaan on Alpha wrote:
> > I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h 
> (the non-smp
> > section) but the same line in include/asm/mmu_context.h 
> works - for a 
> > while.
> 
> I'm running 2.5.24 on sx164 with following (unfinished - SMP 
> is broken) patch.

The patch worked well and did what my patch did not yet. :o)
I compiles without problems. I'll try to boot the machine
tommorow (at work).

I'll send you the results. :o)

Greetz,
  Oliver


