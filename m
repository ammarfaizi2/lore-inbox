Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUEPT6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUEPT6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUEPT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:58:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7860 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263159AbUEPT6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:58:35 -0400
Date: Sun, 16 May 2004 15:58:11 -0400
From: Alan Cox <alan@redhat.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Message-ID: <20040516195811.GH20505@devserv.devel.redhat.com>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A404A5.8070500@keyaccess.nl> <200405140214.08136.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A4B482.3040706@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 01:58:58PM +0200, Rene Herman wrote:
> Have again attached a 'rollup' patch against vanilla 2.6.6, including 
> this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of 
> spindle if rebooting" hack. Again, just in case anyone finds it useful.

This reintroduces corruption on my thinkpad 600.

Alan

