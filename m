Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSJaPmD>; Thu, 31 Oct 2002 10:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJaPmD>; Thu, 31 Oct 2002 10:42:03 -0500
Received: from maruja.satec.es ([213.164.38.66]:23534 "EHLO satec.es")
	by vger.kernel.org with ESMTP id <S262604AbSJaPmB>;
	Thu, 31 Oct 2002 10:42:01 -0500
From: "Adriano Galano" <adriano@satec.es>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel bug in 2.4.7-10smp...
Date: Thu, 31 Oct 2002 16:42:27 +0100
Message-ID: <002101c280f4$1e91c380$6f20a4d5@adriano>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1036065253.8852.57.camel@irongate.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2002-10-31 at 10:41, Adriano Galano wrote:
> > Hi:
> >
Hi Alan:

> > I'm using RH Linux 7.2 (kernel 2.4.7-10smp) in one Compaq
> Proliant ML570
> > with 4 Xeon procesors at 900MHz and one Compaq Smart Array
> 5300 Controller
> > with 6x73 GB SCSI disk with ext3 filesystem.
> >
> > It was working OK, but I have one trouble, description
> below, and the
> > computer it's stopped. Could someone help me? How could I fix it?
>
> Well you could try one of the kernel updates that Red Hat put out for
> this release.
>
I don't apply the patches for possible incompatibility with Compaq Remote
Insight Manager card, the drivers of this card are for 2.4.7
(http://www.compaq.com/support/files/server/us/download/15084.html). Now I'm
trying to make one upgrade to 2.4.18 recompiling the drivers source...  Why
happen this errors in 2.4.7?

Best regards,

-Adriano (bryam)
--
Adriano M. Galano Diez
System & Network Engineer
http://www.satec.es
Phone: (+34) 917 089 000
Sourceforge.NET Linux Kernel Foundry Guide http://sf.net/foundry/linuxkernel



