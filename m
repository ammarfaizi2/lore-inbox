Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWGaGcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWGaGcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWGaGcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:32:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:61892 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751165AbWGaGcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:32:05 -0400
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 31 Jul 2006 16:31:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.41945.205925.685787@cse.unsw.edu.au>
Cc: mingo@redhat.com, linux-raid@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the scheduled removal of the START_ARRAY ioctl for md
In-Reply-To: message from Adrian Bunk on Saturday July 29
References: <20060729174826.GB26963@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 29, bunk@stusta.de wrote:
> This patch contains the scheduled removal of the START_ARRAY ioctl for md.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks.  I had a patch to do this queued up, but yours is more
thorough (mine didn't touch feature-removal-schedule.txt or
compat_ioctl.h)

Thanks.
NeilBrown
