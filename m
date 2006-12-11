Return-Path: <linux-kernel-owner+w=401wt.eu-S1762711AbWLKKHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762711AbWLKKHm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762712AbWLKKHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:07:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:16704 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762711AbWLKKHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:07:41 -0500
Date: Mon, 11 Dec 2006 11:08:53 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 63/87] md: define raid5_mergeable_bvec
Message-ID: <20061211100853.GJ4576@kernel.dk>
References: <200612101020.kBAAKjJB021309@shell0.pdx.osdl.net> <20061211074825.GA4576@kernel.dk> <5d96567b0612110054u7e4bd628xc217c04ab6835d5f@mail.gmail.com> <20061211090301.GH4576@kernel.dk> <5d96567b0612110204w10bd9029v1305495cd1628a6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96567b0612110204w10bd9029v1305495cd1628a6b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11 2006, Raz Ben-Jehuda(caro) wrote:
> this is against 2.6.19-git17
> hope this correct

Patch itself looks fine. Some general suggestions for the future:

- Don't top post on lkml
- Inline patches, and always include a description and a Signed-off-by
  line.
- Documentation/SubmittingPatches has a lot of good info.

-- 
Jens Axboe

