Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUFJGU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUFJGU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUFJGU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:20:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18104 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264503AbUFJGUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:20:50 -0400
Date: Thu, 10 Jun 2004 08:11:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040610061141.GD13836@suse.de>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100238.11857.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> /me just thinks loudly
> 
> 'linear range' FLUSH CACHE seems so easy to implement that I always wondered
> why FLUSH CACHE command doesn't make any use of LBA address and number
> of sectors.

Indeed, that would be very helpful as well.

-- 
Jens Axboe

