Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTKXTEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTKXTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:04:34 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13710 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263836AbTKXTEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:04:32 -0500
Date: Mon, 24 Nov 2003 16:58:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-rc4
Message-ID: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -rc4, fixing modular IDE breakage present in 2.4.23 kernels.

Hopefully this will become final.

Enjoy

Summary of changes from v2.4.23-rc3 to v2.4.23-rc4
============================================

<arekm:pld-linux.org>:
  o Fix modular IDE

<lethal:unusual.internal.linux-sh.org>:
  o sh64: Fixup zImage build for recent ITLB/DTLB changes
  o sh64: Update defconfig
  o sh: SH7751 documentation updates
  o sh/sh64: Clear IRQ_INPROGRESS in setup_irq()
  o sh: Add SH-DSP support

Richard Curnow:
  o sh64: Update MAINTAINERS

Willy Tarreau:
  o fix 2 broken links in bonding documentation




