Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUFGKdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUFGKdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 06:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUFGKdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 06:33:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2530 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264392AbUFGKdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 06:33:38 -0400
Date: Mon, 7 Jun 2004 12:33:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040607103334.GJ13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406072008.07176.kernel@kolivas.org> <20040607101732.GI13836@suse.de> <200406072029.09765.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406072029.09765.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2004, Con Kolivas wrote:
> On Mon, 7 Jun 2004 20:17, Jens Axboe wrote:
> > So that didn't help at all... Hmm I wonder what to do about this. So
> > last failure was NOT_READY - does it make a difference if you have a
> > medium loaded or not?
> 
> Indeed it does:

Great, I'll move the checks around then and postpone it until open time.
Best place to do it anyways. Thanks for your patient testing :-)

-- 
Jens Axboe

