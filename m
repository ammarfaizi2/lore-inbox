Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSG2MXQ>; Mon, 29 Jul 2002 08:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSG2MXP>; Mon, 29 Jul 2002 08:23:15 -0400
Received: from [196.26.86.1] ([196.26.86.1]:39402 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316339AbSG2MXP>; Mon, 29 Jul 2002 08:23:15 -0400
Date: Mon, 29 Jul 2002 12:31:59 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       <linux-kernel@vger.kernel.org>, lse <lse-tech@lists.sourceforge.net>,
       <riel@conectiva.com.br>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using
 kmalloc_percpu
In-Reply-To: <490876873.1027866798@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0207291225130.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Martin J. Bligh wrote:

> The strangest thing to me is that all the IDs are 0, when they
> weren't to start with. Something's corrupting memory ... I'd
> happily blame my own code, but allegedly this has happened without
> CONFIG_MULTIQUAD too.

Do you know wether its just the IDs or the whole mp_ioapic[x] struct?

	Zwane Mwaikambo

-- 
function.linuxpower.ca

