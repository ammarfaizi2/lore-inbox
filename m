Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBOUTj>; Thu, 15 Feb 2001 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBOUT3>; Thu, 15 Feb 2001 15:19:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39177 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129078AbRBOUTR>; Thu, 15 Feb 2001 15:19:17 -0500
Subject: Re: 2.4.1ac13/14 problem
To: soci@singular.sch.bme.hu (Kajtar Zsolt)
Date: Thu, 15 Feb 2001 20:19:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102151917150.233-100000@singular.sch.bme.hu> from "Kajtar Zsolt" at Feb 15, 2001 08:01:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TUs4-0000la-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Calibrating delay loop... 466.94 BogoMIPS
> Memory: 62836k/65536k available (712k kernel code, 2312k reserved, 188k
> data, 56k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode...
> 
> Here it freezes forever... My cpu:
> 
> vendor_id	: CyrixInstead

Ok I've been trying to fix the Cyrix/cpuid problems and it appears I
may have overdone it. I'll reread the code in detail.

Alan

