Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289003AbSANURN>; Mon, 14 Jan 2002 15:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSANUPx>; Mon, 14 Jan 2002 15:15:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:60676 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288992AbSANUOL>;
	Mon, 14 Jan 2002 15:14:11 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114113910.A24210@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com>
	<E16QC5P-0000nO-00@starship.berlin>  <20020114113910.A24210@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 15:16:45 -0500
Message-Id: <1011039432.4604.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 13:39, yodaiken@fsmlabs.com wrote:

> > You're claiming that preemption by nature is not Unix-like?
> 
> Kernel preemption is not traditionally part of UNIX. 

True original AT&T was non-preemptible, but it also didn't originally
have paging.  Today, Solaris, IRIX, latest BSD (via BSDng), etc. are all
preemptible kernels.

Ask Core whether SMPng in FreeBSD 5.0 will include preempt, I think they
are still debating.

	Robert Love

