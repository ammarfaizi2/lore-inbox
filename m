Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSK3Cgq>; Fri, 29 Nov 2002 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbSK3Cgq>; Fri, 29 Nov 2002 21:36:46 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:65356
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267206AbSK3Cgp>; Fri, 29 Nov 2002 21:36:45 -0500
Date: Fri, 29 Nov 2002 21:47:17 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Javier Marcet <jmarcet@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <conman@kolivas.net>
Subject: Re: Exaggerated swap usage
In-Reply-To: <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50.0211292145240.26051-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Rik van Riel wrote:

> If the problem is (1) it might get resolved by using the -rmap
> or -aa kernels.  If the problem is (2) you'll want Andrew Morton's
> read_latency patch (which I'll port to 2.4.20 real soon now).

The read_latency makes an immense difference, i've CC'd Con because
there was one other bit which i needed to get IO from stalling the box
(5-10s) which i can't recall right now.

Cheers,
	Zwane
-- 
function.linuxpower.ca
