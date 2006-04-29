Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWD2EpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWD2EpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 00:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWD2EpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 00:45:00 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31243 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932483AbWD2Eo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 00:44:59 -0400
Date: Sat, 29 Apr 2006 06:43:15 +0200
From: Willy Tarreau <willy@w.ods.org>
To: khaled MOHAMMED atteya <khaled.m.atteya@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I hope to be kernel developer ,in i386 arch
Message-ID: <20060429044314.GI13027@w.ods.org>
References: <7f9112a50604281454k27d60e4cm61d5bb659c3f8359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9112a50604281454k27d60e4cm61d5bb659c3f8359@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Apr 29, 2006 at 12:54:28AM +0300, khaled MOHAMMED atteya wrote:
> HELLO
> I hope to be kernel developer ,in i386 arch.
> am i needing to read all i386 and pentium manual (the three volume)?

For kernel development, you don't necessary need to start from the CPU
manuals. Starting from the kernel code would be more efficient. Then,
once you feel you really need to get specific CPU knowledge, take a look
at its manual. Generally, the i386 manual + some experience with this
CPU will be enough to understand most code. Newer x86 CPUs reuse the
same instruction set and model, and add a few instructions and memory
models. Also, it might be wise to get basic knowledge on the PC
architecture if you don't have right now (I/O, mem, DMA, PCI, IRQs, ...). 

Hoping this helps,
Willy

