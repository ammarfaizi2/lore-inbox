Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSG1TP2>; Sun, 28 Jul 2002 15:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSG1TP2>; Sun, 28 Jul 2002 15:15:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317165AbSG1TP1>;
	Sun, 28 Jul 2002 15:15:27 -0400
Date: Sun, 28 Jul 2002 12:17:38 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
In-Reply-To: <20020728211204.A3203@suse.de>
Message-ID: <Pine.LNX.4.33L2.0207281216060.20127-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Jens Axboe wrote:

| Cool. I'd be interested in latency and throughput results at this point,
| I have none of these. BTW, does anyone know of a good benchmark that
| also cares about latency?

Danger, use of 'good' and 'benchmark' together.
Nevertheless, tiobench (tiobench.sf.net) tries to care about &
measure latency.

-- 
~Randy

