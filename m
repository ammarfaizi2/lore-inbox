Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTLDIQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTLDIQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:16:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48575 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263176AbTLDIQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:16:15 -0500
Date: Thu, 4 Dec 2003 09:16:03 +0100
From: Jens Axboe <axboe@suse.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd 2.6.0-test11 does not work
Message-ID: <20031204081603.GA1086@suse.de>
References: <20031202163856.GA16759@thumper2.emsphone.com> <200312022026.47485.bzolnier@elka.pw.edu.pl> <bql1s1$i31$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bql1s1$i31$1@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03 2003, bill davidsen wrote:
> In article <200312022026.47485.bzolnier@elka.pw.edu.pl>,
> Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> | 
> | Do you have IDE CD support compiled-in or as module (ide-cd)?
> 
> I'm assuming that since OP said "loaded" that it was as a module.

Well if it says 'not a valid block device' then either ide-cd isn't
loaded (likely) or he has a corrupt special file (unlikely).

-- 
Jens Axboe

