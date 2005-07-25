Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVGYSOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVGYSOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 14:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGYSOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 14:14:06 -0400
Received: from ozlabs.org ([203.10.76.45]:488 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261401AbVGYSOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 14:14:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17125.11156.794826.51922@cargo.ozlabs.ibm.com>
Date: Mon, 25 Jul 2005 14:12:36 -0400
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ping^2: [PATCH] move /proc/ppc_htab creating self-contained in arch/ppc/ code
In-Reply-To: <20050724225028.GA1349@lst.de>
References: <20050504184439.GA20671@lst.de>
	<20050627210502.GA20487@lst.de>
	<20050724225028.GA1349@lst.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> On Mon, Jun 27, 2005 at 11:05:02PM +0200, Christoph Hellwig wrote:
> > On Wed, May 04, 2005 at 08:44:39PM +0200, Christoph Hellwig wrote:
> > > additional benefit is cleaning up the ifdef mess in ppc_htab.c
> > > 
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > ping?

I would actually rather get rid of /proc/ppc_htab altogether.

Paul.
