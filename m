Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268456AbTBNP0E>; Fri, 14 Feb 2003 10:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268455AbTBNP0E>; Fri, 14 Feb 2003 10:26:04 -0500
Received: from ns.suse.de ([213.95.15.193]:52237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268456AbTBNP0D>;
	Fri, 14 Feb 2003 10:26:03 -0500
Date: Fri, 14 Feb 2003 15:47:23 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][2.5][14/14] smp_call_function_on_cpu - x86_64
Message-ID: <20030214144723.GA25691@wotan.suse.de>
References: <Pine.LNX.4.50.0302140412190.3518-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0302140751530.3518-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302140751530.3518-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 07:52:15AM -0500, Zwane Mwaikambo wrote:
> One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Shouldn't num_cpus be 1 in that case ?

-Andi
