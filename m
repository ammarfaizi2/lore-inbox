Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEFF4C>; Mon, 6 May 2002 01:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSEFF4B>; Mon, 6 May 2002 01:56:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26642 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314101AbSEFF4B>;
	Mon, 6 May 2002 01:56:01 -0400
Date: Mon, 6 May 2002 07:55:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: william stinson <wstinsonfr@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-ID: <20020506055554.GM811@suse.de>
In-Reply-To: <20020505183451.98763.qmail@web14102.mail.yahoo.com> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05 2002, Anton Altaparmakov wrote:
> Note even with that fix IDE (at least TCQ) is really easy to crash when you 
> put the system under heavier I/O (at least on my via box)...

If you have stumpled upon a tcq bug, I'd like to know more about it.

-- 
Jens Axboe

