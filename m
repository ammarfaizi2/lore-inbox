Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVIIULt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVIIULt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbVIIULt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:11:49 -0400
Received: from havoc.gtf.org ([69.61.125.42]:28310 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030440AbVIIULr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:11:47 -0400
Date: Fri, 9 Sep 2005 16:11:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
Message-ID: <20050909201141.GA14862@havoc.gtf.org>
References: <4321E335.5010805@adaptec.com> <20050909193541.GE24673@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909193541.GE24673@kvack.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 03:35:41PM -0400, Benjamin LaHaise wrote:
> A single file per patch is not really a patch split up.  Patches should 
> stand on their own, leaving the tree in a compilable functioning state 
> during each step.

Agreed, though for new drivers, this appears to be one way to get new
code past mailing list size filters, making it easier for the linux-scsi
audience to review the code.  The alternative is posting a link, which
cuts down on mailing list spew, but also I bet cuts down on review.

	Jeff



