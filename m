Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282702AbRK0BJe>; Mon, 26 Nov 2001 20:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282704AbRK0BJZ>; Mon, 26 Nov 2001 20:09:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42115 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282702AbRK0BJU>;
	Mon, 26 Nov 2001 20:09:20 -0500
Date: Mon, 26 Nov 2001 17:09:15 -0800 (PST)
Message-Id: <20011126.170915.25406149.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_trace_task() sparc32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111270046380.30097-100000@tahallah.demon.co.uk>
In-Reply-To: <20011126.154625.124867265.davem@redhat.com>
	<Pine.LNX.4.33.0111270046380.30097-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Tue, 27 Nov 2001 00:47:52 +0000 (GMT)
   
   Glad to oblige. I didn't realise I had patched the wrong file (traps.c)
   instead of process.c as I followed the i386 tree and it was implemented in
   traps.c.

It doesn't matter what file it goes into, the choice was
arbitrary.
