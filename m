Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSAUVPJ>; Mon, 21 Jan 2002 16:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288374AbSAUVPB>; Mon, 21 Jan 2002 16:15:01 -0500
Received: from zero.tech9.net ([209.61.188.187]:63760 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288342AbSAUVOq>;
	Mon, 21 Jan 2002 16:14:46 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020121090602.A13715@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com>
	<E16SgwP-0001iN-00@starship.berlin>  <20020121090602.A13715@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 16:16:51 -0500
Message-Id: <1011647882.8596.466.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 11:06, yodaiken@fsmlabs.com wrote:

> I have not seen a single well structured benchmark that shows a significant
> difference. I've seen lots of benchmarks with odd mixes of different patches
> showing something unknown. How about a simple clear dbench?

I and many others have been posting benchmarks for months.

Here:

(average of 4 runs of `dbench 16')
2.5.3-pre1:		25.7608 MB/s
2.5.3-pre1-preempt:	32.341 MB/s

(old, average of 4 runs of `dbench 16')
2.5.2-pre11:		24.5364 MB/s
2.5.2-pre11-preempt:	27.5192 MB/s

	Robert Love

