Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUAINtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 08:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUAINtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 08:49:16 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:59627 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261563AbUAINtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 08:49:15 -0500
Subject: Re: [PATCH] 2.6.1-rc2 ide barrier support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20040109072600.GA18416@suse.de>
References: <20040107134323.GB16720@suse.de>
	 <1073615696.784.181.camel@gaston>  <20040109072600.GA18416@suse.de>
Content-Type: text/plain
Message-Id: <1073655945.796.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 00:45:46 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm? It _is_ in struct drive :-). It could be put in hwgroup actually,
> but I felt it was cleaner in drive (and easier to manage).

Oops :) I misread the patch, or was on crack or something... sorry :)

Ben.


