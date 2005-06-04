Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFDPR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFDPR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFDPRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:17:55 -0400
Received: from stark.xeocode.com ([216.58.44.227]:23242 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261380AbVFDPRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:17:47 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com>
In-Reply-To: <42A14541.6020209@pobox.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 04 Jun 2005 11:17:40 -0400
Message-ID: <87vf4ujgmj.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Several updates to the libata-dev.git repository.  Some of the branches have
> been folded into a new upstream-2.6.13 branch, which holds several changes (see
> attached).  Other branches were updated to the most recent kernel, which
> contained doc updates that caused some minor merge conflicts.
> 
> I haven't yet updated 'passthru' and 'chs-support' branches to the latest
> kernel.
> 
> Git Repository URL:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> List of branches:
> adma          chs-support  master    pdc2027x           sleeping-eh
> adma-mwi      iomap        ncq       promise-sata-pata  upstream-2.6.13
> atapi-enable  iomap-step1  passthru  sil24

Are there diffs downloadable for these? In particular I'm looking for
passthru. I'm imagining that with passthru SMART works?

-- 
greg

