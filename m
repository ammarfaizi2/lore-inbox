Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSACMbV>; Thu, 3 Jan 2002 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSACMbC>; Thu, 3 Jan 2002 07:31:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5637 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287204AbSACMa5>; Thu, 3 Jan 2002 07:30:57 -0500
Subject: Re: ISA slot detection on PCI systems?
To: balbir.singh@wipro.com (BALBIR SINGH)
Date: Thu, 3 Jan 2002 12:40:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        dwmw2@infradead.org (David Woodhouse), davej@suse.de (Dave Jones),
        Lionel.Bouton@free.fr (Lionel Bouton),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <AAEGIMDAKGCBHLBAACGBMEMNCCAA.balbir.singh@wipro.com> from "BALBIR SINGH" at Jan 03, 2002 05:37:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M7Ab-0008DP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This would break things like cross-compilation. Not sure how many people
> use it though. You will have to be on the machine for which you intend
> to compile the kernel. If you are compiling the kernel for the same machine
> then it is the best thing to happen, provided the software doing the
> configuration for u is not broken

I'm really not too worried about Grandma cross compiling kernels
