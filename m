Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRKMXWQ>; Tue, 13 Nov 2001 18:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279824AbRKMXWG>; Tue, 13 Nov 2001 18:22:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279818AbRKMXV7>; Tue, 13 Nov 2001 18:21:59 -0500
Subject: Re: 2.4.14 fails to boot on a MediaGX
To: matlhdam@iinet.net.au (Adam Harvey)
Date: Tue, 13 Nov 2001 23:29:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01111322000300.00696@blackbox.local> from "Adam Harvey" at Nov 13, 2001 10:00:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163mzs-0002k2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've compiled 2.4.14 on a MediaGX running at 133 MHz that I use for a 
> gateway, and am having some difficulty getting it to boot. The last three 
> lines of output are as follows:

What processor did you compile for. 

> Working around Cyrix MediaGX virtual DMA bugs.
> CPU: Cyrix MediaGX 3x Core/Bus Clock
> Checking 'hlt' instruction... OK.

2.4.12-ac was working on my 233Mhz MediaGX. I suspect 2.4.14 does too. I'll
give it a test tho
