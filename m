Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRJJTJD>; Wed, 10 Oct 2001 15:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277367AbRJJTIw>; Wed, 10 Oct 2001 15:08:52 -0400
Received: from [160.131.145.131] ([160.131.145.131]:4113 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S277366AbRJJTIn>;
	Wed, 10 Oct 2001 15:08:43 -0400
Message-ID: <046601c151be$ffd5ead0$839183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC48C0E.760488AA@starband.net> <20011010132829.A1667@cy599856-a.home.com>
Subject: Re: ATA/100 Promise Board
Date: Wed, 10 Oct 2001 15:08:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Josh McKinney" <forming@home.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 10, 2001 2:28 PM
Subject: Re: ATA/100 Promise Board


> On approximately Wed, Oct 10, 2001 at 01:57:34PM -0400, war wrote:
> > Any idea why DMA is sometimes on and sometimes not for a few cdrom
> > drives I have hooked up to my promise controller?
> >
> Someone posted here recently about atapi devices should not be on the
promise card.
>

That was me, and it's still true. Heh. Always attach optical drives directly
to the motherboard, if possible.
On a similar note, I asked Promise a while back about the max number of
supported Ultra66/Ultra100/etc controllers that they support in a single
system.. No answer. Has anyone ever tried to cram a machine full of these
cards?



