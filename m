Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbTLRIfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbTLRIfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:35:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48589 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265211AbTLRIfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:35:34 -0500
Date: Thu, 18 Dec 2003 09:35:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Milos Prudek <milos.prudek@tiscali.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031218083530.GP2495@suse.de>
References: <3FE16489.9060006@tiscali.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE16489.9060006@tiscali.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18 2003, Milos Prudek wrote:
> I noticed that Jens Axboe's patch to allow Mount Rainier support did not 
> make it into 2.6.0-test11.
> 
> Current Mount Rainier patch fails on 2.4.22.
> 
> Will Jens Axboe's patch be updated for 2.4.x and/or 2.6.x ?

I just ported the patch yesterday, I'll post it for testing later today.
If testing goes fine, I would imagine an inclusion in 2.6.1/2 would not
be out of the question.

-- 
Jens Axboe

