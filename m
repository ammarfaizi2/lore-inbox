Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTAJQUR>; Fri, 10 Jan 2003 11:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTAJQUR>; Fri, 10 Jan 2003 11:20:17 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:25842
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265099AbTAJQUR>; Fri, 10 Jan 2003 11:20:17 -0500
Date: Fri, 10 Jan 2003 11:28:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Shawn Starr <spstarr@sh0n.net>
cc: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54][PATCH] SB16 convertation to new PnP layer.
In-Reply-To: <Pine.LNX.4.44.0301101104170.6588-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.50.0301101128060.7163-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301101104170.6588-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Shawn Starr wrote:

>
> What was this patched against? It doesn't go in to 2.5.55 too many
> rejects.

Applied clean against 2.5.55 here, you must have a broken tree.

zwane@montezuma linux-2.5.55 {0} patch -p0 --dry-run < ~/patch-sb16-alsa-ruslan
patching file sound/isa/sb/sb16.c

-- 
function.linuxpower.ca
