Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261207AbSIWMmW>; Mon, 23 Sep 2002 08:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSIWMmW>; Mon, 23 Sep 2002 08:42:22 -0400
Received: from codepoet.org ([166.70.99.138]:34703 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S261207AbSIWMmV>;
	Mon, 23 Sep 2002 08:42:21 -0400
Date: Mon, 23 Sep 2002 06:47:31 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Con Kolivas <conman@kolivas.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020923124730.GA7556@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Con Kolivas <conman@kolivas.net>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain> <1032777021.3d8eed3d55f53@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032777021.3d8eed3d55f53@kolivas.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> Yes you make a very valid point and something I've been stewing over privately
> for some time. contest runs benchmarks in a fixed order with a "priming" compile
> to try and get pagecaches etc back to some sort of baseline (I've been trying
> hard to make the results accurate and repeatable). 

It would sure be nice for this sortof test if there were
some sort of a "flush-all-caches" syscall...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
