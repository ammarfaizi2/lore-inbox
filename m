Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVAGXnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVAGXnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVAGXdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:33:32 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:55682 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261737AbVAGXcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:32:24 -0500
Subject: RE: [PATCH 2.6] cciss typo fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DC0185@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107DC0185@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 18:32:02 -0500
Message-Id: <1105140722.4151.28.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 17:24 -0600, Miller, Mike (OS Dev) wrote:
> Hmmm, SuSE complained that __be32 was not defined in the kernel. Any other thoughts, anyone?

Erm, well it might not be defined in the SuSE kernel ... that's based on
2.6.5, I believe.  These symbols are definitely defined in the mainline
kernel.

James


