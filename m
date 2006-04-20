Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWDTK03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDTK03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDTK02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750770AbWDTK02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:26:28 -0400
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 20 Apr 2006 20:26:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17479.25030.263043.617346@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
In-Reply-To: message from Jens Axboe on Thursday April 20
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<17479.21320.361708.237802@cse.unsw.edu.au>
	<20060420093056.GA614@suse.de>
	<17479.22902.770558.600574@cse.unsw.edu.au>
	<20060420095954.GB13279@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 20, axboe@suse.de wrote:
> 
> That code is ancient :-). See -rc2.

Ahhh...  golly, you're right.  It's nearly two weeks old now.  It's
hard to get the hang of Internet-time sometimes :-)
Sorry for the noise.

NeilBrown
