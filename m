Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbRE1VaD>; Mon, 28 May 2001 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263171AbRE1V3w>; Mon, 28 May 2001 17:29:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263170AbRE1V3n>; Mon, 28 May 2001 17:29:43 -0400
Subject: Re: Broken memory init on VIA KX133
To: Dylan_G@bigfoot.com (Dylan Griffiths)
Date: Mon, 28 May 2001 22:27:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3B12C1A2.123C15BE@bigfoot.com> from "Dylan Griffiths" at May 28, 2001 03:22:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154UXz-0003Yl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I'm wondering if anyone knows/has a fix for memory past 64mb not being
> detected (unless you use append="mem=...M" in lilo) on the Via VT8371
> [KX133] North bridge.   (Please CC any replies since I'm off kernel list
> atm.)

Consult your BIOS vendor


