Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTE0JEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTE0JEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:04:46 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:32898
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262946AbTE0JEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:04:40 -0400
Date: Tue, 27 May 2003 05:07:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "John T. Guthrie" <guthrie@counterexample.org>
cc: linux-kernel@vger.kernel.org, "" <hermes@gibson.dropbear.id.au>
Subject: Re: [OOPS] reading /proc/hermes/eth1/recs causes an oops in 2.5.69
In-Reply-To: <200305270803.h4R83dMc010911@gauss.counterexample.org>
Message-ID: <Pine.LNX.4.50.0305270506120.2265-100000@montezuma.mastecende.com>
References: <200305270803.h4R83dMc010911@gauss.counterexample.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, John T. Guthrie wrote:

> Unable to handle kernel paging request at virtual address f00af00a
> c013f791
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c013f791>]    Not tainted

I'd love to know what symbol that is, can you try and resolve it?

> Call Trace:
>  [<c013f6c0>] reap_timer_fnc+0x0/0x230

Hmm

	Zwane
-- 
function.linuxpower.ca
