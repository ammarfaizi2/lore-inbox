Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264823AbTE1SaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbTE1SaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:30:20 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:12929
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264823AbTE1SaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:30:20 -0400
Date: Wed, 28 May 2003 14:32:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jens Axboe <axboe@suse.de>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, "" <kernel@kolivas.org>,
       "" <matthias.mueller@rz.uni-karlsruhe.de>, "" <manish@storadinc.com>,
       "" <andrea@suse.de>, "" <marcelo@conectiva.com.br>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <Pine.LNX.4.50.0305281416480.1982-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305281430340.1982-100000@montezuma.mastecende.com>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de>
 <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de>
 <20030528125312.GV845@suse.de> <Pine.LNX.4.50.0305281416480.1982-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Zwane Mwaikambo wrote:

> I can reproduce across spindles with cvs import'ing a kernel tree,
> make sure you're running X11 and try and do things in it, e.g. scrolling 
> windows, dragging etc.

Forgot to mention, 2x 400MHz/512MB RAM, read is from UW2/7200 write to 
UDMA33/5400 (w/ 2MB cache).

	Zwane
-- 
function.linuxpower.ca
