Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbRE3UOp>; Wed, 30 May 2001 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbRE3UOf>; Wed, 30 May 2001 16:14:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262009AbRE3UO0>; Wed, 30 May 2001 16:14:26 -0400
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
To: linuxkernel@AdvancedResearch.org (Vincent Stemen)
Date: Wed, 30 May 2001 21:11:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        mikeg@wen-online.de (Mike Galbraith)
In-Reply-To: <01053014585700.01976@quark> from "Vincent Stemen" at May 30, 2001 02:58:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155CJM-0006XT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was a new 8139too driver added to the the 2.4.5 (I think) kernel
> which Alan Cox took back out and reverted to the old one in his
> 2.4.5-ac? versions because it is apparently causing lockups.
> Shouldn't this new driver have been released in a 2.5.x development
> kernel and proven there before replacing the one in the production
> kernel?  I haven't even seen a 2.5.x kernel released yet.

Nope. The 2.4.3 one is buggy too - but differently (and it turns out a 
little less) buggy. Welcome to software.

