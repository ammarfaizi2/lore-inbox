Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTE0VU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTE0VU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:20:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56731
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264158AbTE0VU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:20:26 -0400
Date: Tue, 27 May 2003 23:33:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527213340.GV3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305272032.03645.m.c.p@wolk-project.de> <20030527201028.GJ3767@dualathlon.random> <200305272224.22567.m.c.p@wolk-project.de> <20030527205516.GZ845@suse.de> <20030527210518.GQ8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527210518.GQ8978@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:05:18PM -0700, William Lee Irwin III wrote:
> They've backported everything else, so I guess it stood to reason it'd
> happen eventually.

you probably forgot we have varyio in 2.4 due the lack of bio ;)

Andrea
