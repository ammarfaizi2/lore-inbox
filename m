Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTGAQEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTGAQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:04:47 -0400
Received: from mail3-211.ewetel.de ([212.6.122.211]:30398 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S262584AbTGAQEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:04:43 -0400
Date: Tue, 1 Jul 2003 18:19:04 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-cd: capability flag for MO drives
In-Reply-To: <20030701071933.GC26543@suse.de>
Message-ID: <Pine.LNX.4.44.0307011818500.1165-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Jens Axboe wrote:

> > Add capability flag for MO drives. Since ATAPI MOs are now recognized
> > by the ide-cd driver, it is useful to have a capability flag to be able
> > to tell MO drives from other drives (needed for later write support).
> 
> It looks fine, sent on...

Thanks!

-- 
Ciao,
Pascal

