Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRJUO5C>; Sun, 21 Oct 2001 10:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276150AbRJUO4w>; Sun, 21 Oct 2001 10:56:52 -0400
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:2308 "EHLO
	mail.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S276138AbRJUO4i>; Sun, 21 Oct 2001 10:56:38 -0400
Date: Sun, 21 Oct 2001 17:10:28 +0200 (CEST)
From: Sten <sten@blinkenlights.nl>
To: linux-kernel@vger.kernel.org
Subject: INIT_MMAP on sparc64
Message-ID: <Pine.LNX.4.40-blink.0110211702070.19859-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been playing around with linux on an ultra60,
and have had some struggles with the kernel.
The most annoying one is that somewhere in between
kernels 2.4.7 and 2.4.12 someone delete the define
of INIT_MMAP from the processor.h of sparc64, which
doesnt really help when trying to compile a kernel.

Putting in the define of 2.4.7 got me on the way.
So putting it back might be a nice idea ;)

Ow well, still better as solaris, for my purposes
atleast.

--

Sten Spans

