Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263850AbTCVQ5n>; Sat, 22 Mar 2003 11:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263852AbTCVQ5n>; Sat, 22 Mar 2003 11:57:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:6982
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263850AbTCVQ5n>; Sat, 22 Mar 2003 11:57:43 -0500
Date: Sat, 22 Mar 2003 12:05:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: BUG: Use after free in detach_pid
In-Reply-To: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303221204180.18911-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention, kernel is 2.5.65-pgcl w/ HIGHMEM + 32k PAGE_SIZE, i 
haven't encountered any memory stomping other than this one so far.

Thanks,
	Zwane
-- 
function.linuxpower.ca
