Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWBGDKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBGDKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWBGDKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:10:22 -0500
Received: from pat.uio.no ([129.240.130.16]:18167 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932159AbWBGDKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:10:21 -0500
Subject: Re: Broken NFS (perhaps Cache invalidation bug ?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "L. D. Marks" <L-marks@northwestern.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GHP.4.63.0602062038470.3104@risc4.numis.northwestern.edu>
References: <Pine.GHP.4.63.0602062038470.3104@risc4.numis.northwestern.edu>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 22:10:04 -0500
Message-Id: <1139281804.7877.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.08, required 12,
	autolearn=disabled, AWL 1.73, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 20:49 -0600, L. D. Marks wrote:
> I have a problem which appears to be very similar to a cache invalidation 
> bug previously reported: 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0510.1/0582.html
> 

Which should be fixed.

Cheers,
  Trond

