Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSJGHXl>; Mon, 7 Oct 2002 03:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbSJGHXk>; Mon, 7 Oct 2002 03:23:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5280 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262905AbSJGHXf>;
	Mon, 7 Oct 2002 03:23:35 -0400
Date: Mon, 7 Oct 2002 09:40:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] NUMA schedulers benchmark results
In-Reply-To: <1338937420.1033950308@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0210070939580.3733-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Martin J. Bligh wrote:

> Profile looks horrible (what the hell is fib_node_get_info?
> net/ipv4/fib_semantics.c):

most likely the wrong System.map?

	Ingo

