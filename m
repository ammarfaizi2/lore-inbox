Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTJaNBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTJaNBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:01:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34208 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263293AbTJaNAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:00:40 -0500
Date: Fri, 31 Oct 2003 14:00:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Message-ID: <20031031130041.GI7314@suse.de>
References: <200310301601.55588.schlicht@uni-mannheim.de> <200310301848.19065.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310301848.19065.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> [ Jens - IDE TCQ maintainer 8) added to cc: ]

Not really (added, that is :)

> Could you also send dmesg output and retry with vanilla -test9?

It's probably via + tcq, that drive is known good with ide-tcq. At least
I've never seen problems with it.

-- 
Jens Axboe

