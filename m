Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUC1H2B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUC1H2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:28:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30443 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262120AbUC1H17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:27:59 -0500
Date: Sun, 28 Mar 2004 09:00:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [discuss] Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040328070015.GB1453@openzaurus.ucw.cz>
References: <20040318231006.GK11010@waste.org> <20040319003252.GB11450@wohnheim.fh-wedel.de> <20040319030942.GM11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319030942.GM11010@waste.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The code for new versions of zlib is significantly scarier last I
> checked and there's no particular advantage to it. But one of the
> primary motivations here is to get to the point where something like
> bunzip2 or even a new zlib is a drop-in replacement.

Some people want fast-but-not-big-ratio compressor for speeding up swsusp.
If compressors are drop-in, thats very good.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

