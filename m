Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbREXEAA>; Thu, 24 May 2001 00:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263360AbREXD7u>; Wed, 23 May 2001 23:59:50 -0400
Received: from sydney2.au.ibm.com ([202.135.142.197]:33288 "HELO
	haven.ozlabs.ibm.com.au") by vger.kernel.org with SMTP
	id <S263359AbREXD7k>; Wed, 23 May 2001 23:59:40 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15116.32589.612298.536757@argo.ozlabs.ibm.com>
Date: Thu, 24 May 2001 13:26:05 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tom_gall@vnet.ibm.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: New iSeries Device Drivers (small update)
In-Reply-To: <E152i2F-0004Gl-00@the-village.bc.nu>
In-Reply-To: <3B0C3F87.1B21F5D5@vnet.ibm.com>
	<E152i2F-0004Gl-00@the-village.bc.nu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> I was ignoring them because I think they should come via the PPC maintainers

It's OK Alan, Tom is one of the maintainers for Linux on i-Series
(AS/400) machines (we just haven't got around to sending the patch to
the MAINTAINERS file yet).  Cort and Tom and I are discussing how best
to merge in the i-Series support into arch/ppc and include/asm-ppc but
these drivers can go in as far as I am concerned (and AFAIK Cort
agrees).

Regards,
Paul.

