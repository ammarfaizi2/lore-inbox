Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284438AbRLCIvg>; Mon, 3 Dec 2001 03:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284441AbRLCIuU>; Mon, 3 Dec 2001 03:50:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60567 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284434AbRLBXsk>;
	Sun, 2 Dec 2001 18:48:40 -0500
Date: Sun, 02 Dec 2001 15:48:36 -0800 (PST)
Message-Id: <20011202.154836.02303146.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.17-pre2: Missing show_trace_task() implementation
 on sparc32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112011432340.2476-100000@tahallah.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0112011432340.2476-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Sat, 1 Dec 2001 14:37:34 +0000 (GMT)

   I see that the fix for implementation of show_trace_task() is missing from
   the sparc32 tree in 2.4.17-pre1 and 2.4.17-pre2. Dave M has redone my
   quick and dirty patch and placed it in arch/sparc/process.c
   
   Here is the patch to include in 2.4.17-pre3, thanks.

It's in Marcelo's backlog, most likely.
