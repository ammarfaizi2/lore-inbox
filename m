Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbREYXI1>; Fri, 25 May 2001 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbREYXIS>; Fri, 25 May 2001 19:08:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262022AbREYXIG>; Fri, 25 May 2001 19:08:06 -0400
Subject: Re: The difference between Linus's kernel and Alan Cox's kernel
To: tvinhas@networx.com.br (Thiago Vinhas de Moraes)
Date: Sat, 26 May 2001 00:05:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <01052517123904.01385@zeus.networx.com.br> from "Thiago Vinhas de Moraes" at May 25, 2001 05:12:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153QeK-0007Cs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why there are two different kernel trees? There is always the official 
> release, provided by Torvalds, and then Alan provides a patch merging Linus's 
> stuff, and adding (?) tons of bug fixes.

Well it started by accident but it turns out good to have a tree that changes
are merged into, tested by those who need the fixes and reviewed by third
parties before they go to Linus.

So the -ac tree is kind of a peer review, testing and distillation process for
patches.

