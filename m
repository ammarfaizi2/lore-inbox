Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSKOAKq>; Thu, 14 Nov 2002 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKOAKq>; Thu, 14 Nov 2002 19:10:46 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:30987 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S265355AbSKOAKp>; Thu, 14 Nov 2002 19:10:45 -0500
Date: Fri, 15 Nov 2002 01:17:38 +0100
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: rl@hellgate.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine weirdness with via kt8235 Southbridge
Message-ID: <20021115011738.D17058@pc9391.uni-regensburg.de>
References: <20021115002822.G6981@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021115002822.G6981@pc9391.uni-regensburg.de>; from christian.guggenberger@physik.uni-regensburg.de on Fri, Nov 15, 2002 at 00:28:22 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 23 Oct 2002 15:49:31 +0200, Christian Guggenberger wrote:
>> This concerns both 2.4 and 2.5 kernels  (testet with 2.4.20pre*aa series,
>> and with 2.5.43, 2.5.44 and 2.5.44-ac1):
>> 
>> When I enable APIC in the Bios, the via-rhine module will insert
>> properly, but I won't get a link... With APIC disabled, link is ok.  Ok,
>> this could be caused by buggy bios, so I'll try again, when a new
>> biosversion is available.
> 
> Yeah, it seems there's a problem with IO-APICs. I currently don't have a
> machine with IO-APIC for testing, though, so...
> 

A new Biosversion is installed on my mobo now, but that APIC problem is still
there.
Are there some dumps I could post to get some light on that topic?

Maybe some outputs of via-diag, mii-diag, lspci, dmesg ...?
If they could help, what options should I pass to mii-diag and via-diag ?


Christian

