Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUB2Bu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUB2Bu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 20:50:56 -0500
Received: from waste.org ([209.173.204.2]:49894 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261964AbUB2Buz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 20:50:55 -0500
Date: Sat, 28 Feb 2004 19:50:41 -0600
From: Matt Mackall <mpm@selenic.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
Message-ID: <20040229015041.GQ3883@waste.org>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402290121.30498.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 01:21:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> I like Alan's idea to use loopback instead of "bswap".

Or, more likely, device mapper.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
