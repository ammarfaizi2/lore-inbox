Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282690AbRK0AyO>; Mon, 26 Nov 2001 19:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282693AbRK0AyF>; Mon, 26 Nov 2001 19:54:05 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:29710 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282691AbRK0Axv>; Mon, 26 Nov 2001 19:53:51 -0500
Date: Tue, 27 Nov 2001 00:47:52 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] show_trace_task() sparc32
In-Reply-To: <20011126.154625.124867265.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0111270046380.30097-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, David S. Miller wrote:

> Thanks for pointing this out, the following is in CVS and was passed
> on to Marcelo for 2.4.17-preX...

Glad to oblige. I didn't realise I had patched the wrong file (traps.c)
instead of process.c as I followed the i386 tree and it was implemented in
traps.c.

-- 
Broken hearted, but not down.

http://www.tahallah.demon.co.uk

