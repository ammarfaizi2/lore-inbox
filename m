Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTGAHFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGAHFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:05:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19167 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261196AbTGAHFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:05:11 -0400
Date: Tue, 1 Jul 2003 09:19:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-cd: capability flag for MO drives
Message-ID: <20030701071933.GC26543@suse.de>
References: <Pine.LNX.4.44.0306292142580.1272-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306292142580.1272-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29 2003, Pascal Schmidt wrote:
> 
> 3rd resend. Please apply or tell me what is wrong with it...
> 
> Add capability flag for MO drives. Since ATAPI MOs are now recognized
> by the ide-cd driver, it is useful to have a capability flag to be able
> to tell MO drives from other drives (needed for later write support).

It looks fine, sent on...

-- 
Jens Axboe

