Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbTBVXoD>; Sat, 22 Feb 2003 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTBVXoD>; Sat, 22 Feb 2003 18:44:03 -0500
Received: from coffee.Psychology.mcmaster.ca ([130.113.218.59]:11440 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S267979AbTBVXoC>; Sat, 22 Feb 2003 18:44:02 -0500
Date: Sat, 22 Feb 2003 18:54:10 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030222232349.A31768@infradead.org>
Message-ID: <Pine.LNX.4.44.0302221844120.2686-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I could ask the SGI Eagan folks to do that with an Altix and a IA64
> Whitebox  - oh wait, both OSes would be Linux..

the only public info I've seen is "round-trip in as little as 40ns",
which is too vague to be useful.  and sounds WAY optimistic - perhaps
that's just between two CPUs in a single brick.  remember that 
LMBench shows memory latencies of O(100ns) for even fast uniprocessors.

