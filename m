Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTLPAMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLPAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:12:17 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:38342 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264145AbTLPAMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:12:16 -0500
Date: Mon, 15 Dec 2003 19:11:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <3FDE41BC.8000305@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312151906250.2102@montezuma.fsmlabs.com>
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au>
 <Pine.LNX.4.58.0312151517290.2102@montezuma.fsmlabs.com> <3FDE41BC.8000305@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Nick Piggin wrote:

> Thats weird. I assume you don't have problems with the regular SMP kernel.
> Unfortunately I don't have an HT box I can do these sorts of tests with.
> The first thing you could try is with CONFIG_SCHED_SMT 'N'.

Yes the regular SMP kernel is fine, it's rather hard to work with so i had
to back it out. i'll give it a go with CONFIG_SCHED_SMT a bit later in the week
and let you know.

Thanks
