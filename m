Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268875AbRHBK60>; Thu, 2 Aug 2001 06:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268847AbRHBK6Q>; Thu, 2 Aug 2001 06:58:16 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:11136 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S268875AbRHBK6E>; Thu, 2 Aug 2001 06:58:04 -0400
Message-ID: <3B693172.E37A331A@randomlogic.com>
Date: Thu, 02 Aug 2001 03:54:42 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il> <3B690A63.5068B279@theOffice.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agus Budy Wuysang wrote:
> 

[SNIP]
> 
> http://heroinewarrior.com/athlon.php3
> 
> >From their /proc/cpuinfo output I say it is kernel 2.4.x...
> 
> They got large pictures & some timing comparison
> against dual Alpha & dual PIII.
> 

One more note here (I was reminded of this as I was looking through the
PCI fixup code). They mention DMA hanging the system. Early versions of
the MP chipset had a DMA problem that caused crashes (hangs). This has
been fixed in the more recent version of the AMD-762.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
