Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRI0UVO>; Thu, 27 Sep 2001 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRI0UVE>; Thu, 27 Sep 2001 16:21:04 -0400
Received: from ns1.vieo.com ([216.30.79.130]:23045 "EHLO Worf.VIEO.com")
	by vger.kernel.org with ESMTP id <S273877AbRI0UUt>;
	Thu, 27 Sep 2001 16:20:49 -0400
Date: Thu, 27 Sep 2001 15:21:16 -0500 (CDT)
From: John Kingman <kingman@VIEO.com>
To: linux-kernel@vger.kernel.org
Subject: get_current()
Message-ID: <Pine.LNX.4.21.0109271518350.12110-100000@Worf.VIEO.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write portable driver code.

What is the status of get_current()?  I see that it is defined in

  asm-arm/current.h
  asm-i386/current.h
  asm-parisc/current.h
  asm-s390/current.h
  asm-sh/current.h

but not in

  asm-alpha/current.h
  asm-ia64/current.h
  asm-m68k/current.h
  asm-mips/current.h
  asm-mips64/current.h
  asm-ppc/current.h
  asm-sparc/current.h
  asm-sparc64/current.h 

Thanks,

John Kingman

