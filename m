Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262897AbTCQGFW>; Mon, 17 Mar 2003 01:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262898AbTCQGFW>; Mon, 17 Mar 2003 01:05:22 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:42021
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262897AbTCQGFV>; Mon, 17 Mar 2003 01:05:21 -0500
Date: Mon, 17 Mar 2003 01:11:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16
 IOAPICs, 223 IRQs
In-Reply-To: <20030317055415.GM5891@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
 <20030317055415.GM5891@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:

> Running out of IRQ's? Simply jacking up NR_IRQS and HARDIRQ_BITS should
> suffice if this is what I think it is.

I'll have to see what repurcussions that will bring about, but i'll add 
that to the TODO list.

	Zwane
-- 
function.linuxpower.ca
