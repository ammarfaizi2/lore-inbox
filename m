Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281713AbRKULMV>; Wed, 21 Nov 2001 06:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKULME>; Wed, 21 Nov 2001 06:12:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37901 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281703AbRKULLw>; Wed, 21 Nov 2001 06:11:52 -0500
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
To: alastair.stevens@mrc-bsu.cam.ac.uk (Alastair Stevens)
Date: Wed, 21 Nov 2001 11:18:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111210945590.795-100000@gurney> from "Alastair Stevens" at Nov 21, 2001 09:53:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166VOz-0004kH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
> CPU1 is instead labelled just "AMD Athlon(tm) Processor".

Those strings are read directly out of the CPU. Mine for example says

cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 1

Alan

