Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFTNOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFTNOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFTNOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:14:51 -0400
Received: from pat.uio.no ([129.240.130.16]:30116 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261170AbVFTNN2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:13:28 -0400
Subject: Re: Pending AIO work/patches
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       wli@holomorphy.com, zab@zabbo.net, mason@suse.com, ysaito@hpl.hp.com
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
References: <20050620120154.GA4810@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jun 2005 09:13:08 -0400
Message-Id: <1119273188.11129.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.597, required 12,
	autolearn=disabled, AWL 1.22, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 20.06.2005 Klokka 17:31 (+0530) skreiv Suparna Bhattacharya:

> (5) Asynchronous semaphore implementation (Ben/Trond?)
> 	Status: Posted - under development & discussion

I'm working on something that attempts to define per-arch low-level
primitives (essentially wrappers to the current arch specific code). I
expect to post something in the next 2 weeks (or at least before the
kernel summit)...

Cheers,
  Trond

