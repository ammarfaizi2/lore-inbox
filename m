Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbTEIH1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbTEIH1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:27:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262329AbTEIH1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:27:33 -0400
Date: Fri, 9 May 2003 09:40:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030509074008.GE20941@suse.de>
References: <20030508163441.GG20941@suse.de> <Pine.SOL.4.30.0305081839190.24013-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305081839190.24013-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> btw. Jens, do you have any benchmarks of using 1MiB requests
>      and/or removing 48-bit overhead?

I'll try to do some timings on the 48-bit overhead today, should be able
to make the analyzer work now...

-- 
Jens Axboe

