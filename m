Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSG1TXR>; Sun, 28 Jul 2002 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSG1TXR>; Sun, 28 Jul 2002 15:23:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317117AbSG1TXQ>;
	Sun, 28 Jul 2002 15:23:16 -0400
Date: Sun, 28 Jul 2002 21:26:53 +0200
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020728212653.B3460@suse.de>
References: <20020728211204.A3203@suse.de> <Pine.LNX.4.33L2.0207281216060.20127-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0207281216060.20127-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28 2002, Randy.Dunlap wrote:
> On Sun, 28 Jul 2002, Jens Axboe wrote:
> 
> | Cool. I'd be interested in latency and throughput results at this point,
> | I have none of these. BTW, does anyone know of a good benchmark that
> | also cares about latency?
> 
> Danger, use of 'good' and 'benchmark' together.

:-)

> Nevertheless, tiobench (tiobench.sf.net) tries to care about &
> measure latency.

Does it? Hmm my version is probably too old then, thanks for the hint,
I'll try it first thing tomorrow.

-- 
Jens Axboe

