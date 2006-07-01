Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWGAWzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWGAWzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWGAWzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:55:16 -0400
Received: from havoc.gtf.org ([69.61.125.42]:35285 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751368AbWGAWzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:55:14 -0400
Date: Sat, 1 Jul 2006 18:54:48 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Grant Wilson <grant.wilson@zen.co.uk>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@suse.de>, linux-scsi@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060701225448.GB12703@havoc.gtf.org>
References: <20060701033524.3c478698.akpm@osdl.org> <20060701142419.GB28750@tlg.swandive.local> <20060701143047.b3975472.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701143047.b3975472.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 02:30:47PM -0700, Andrew Morton wrote:
> Grant Wilson <grant.wilson@zen.co.uk> wrote:
> > [  155.226233] Oops: 0000 [1] PREEMPT SMP 

Also, would be nice to re-test without preempt.

Disabling preempt _continues_ to fix (bandaid?) problems...

	Jeff



