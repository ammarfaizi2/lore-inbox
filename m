Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSA2Xoq>; Tue, 29 Jan 2002 18:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSA2XnS>; Tue, 29 Jan 2002 18:43:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287109AbSA2XnA>; Tue, 29 Jan 2002 18:43:00 -0500
Subject: Re: PROBLEM: lost interrupt
To: k0156448@students.jku.at
Date: Tue, 29 Jan 2002 23:55:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000001c1a91c$7fcb8fb0$b121abc1@compus> from "Markus Jordan" at Jan 30, 2002 12:27:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vi6N-0005Zi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the kernel doesn't start. The only way to boot is a Suse CD-Rom with
> a kernelversion of 2.2.18, break the installation, and start the kernel
> 2.4.17 with that system.

Are you compiling in ACPI support ?
