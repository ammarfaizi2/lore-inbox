Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266665AbUFWU6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbUFWU6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUFWU6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:58:03 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:54224 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266665AbUFWU57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:57:59 -0400
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
References: <1087481331.2210.27.camel@mulgrave>
	<m33c4tsnex.fsf@defiant.pm.waw.pl>
	<20040618102120.A29213@flint.arm.linux.org.uk>
	<m3brjg7994.fsf@defiant.pm.waw.pl>
	<20040619212246.B8063@flint.arm.linux.org.uk>
	<m3zn6zf68l.fsf@defiant.pm.waw.pl>
	<20040620204723.B641@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 23 Jun 2004 21:32:16 +0200
In-Reply-To: <20040620204723.B641@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 20 Jun 2004 20:47:23 +0100")
Message-ID: <m33c4myssf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> So it's quite correct for this to be a device thing not a platform
> thing.  It _is_ the SA1111 device itself which has the problem.

Now I see that. Many thanks for detailed explanation.
-- 
Krzysztof Halasa, B*FH
