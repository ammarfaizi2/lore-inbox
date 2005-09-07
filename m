Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVIGJTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVIGJTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGJTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:19:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19419 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751109AbVIGJTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:19:46 -0400
Date: Wed, 7 Sep 2005 11:19:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050907091923.GE4785@suse.de>
References: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> The following patchset breaks down the global ide_lock to per-hwgroup lock.
> We have taken the following approach.

Curious, what is the point of this?

-- 
Jens Axboe

