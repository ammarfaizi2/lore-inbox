Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWFFP1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWFFP1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWFFP1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:27:21 -0400
Received: from pat.uio.no ([129.240.10.4]:13993 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932214AbWFFP1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:27:20 -0400
Subject: Re: Linux v2.6.17-rc6
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Klaus S. Madsen" <ksm@evalesco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060606120701.GP5132@hjernemadsen.org>
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
	 <20060606120701.GP5132@hjernemadsen.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 06 Jun 2006 08:27:07 -0700
Message-Id: <1149607627.30804.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.584, required 12,
	autolearn=disabled, AWL 1.42, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 14:07 +0200, Klaus S. Madsen wrote:
> Hi,
> 
> We still experience the NFS client slow down reported by Jakob
> Østergaard in http://lkml.org/lkml/2006/3/31/82, even with 2.6.17-rc6.
> 
> Trond Myklebust have created a patch which we have verified solves this
> problem for 2.6.16, 2.6.17-rc4 and 2.6.17-rc6. The patch is available
> from http://lkml.org/lkml/2006/4/24/320, and as an attachment to
> bugzilla bug 6557.

The patch is already queued up for inclusion in 2.6.18. I'm not planning
on submitting it for 2.6.17 since it is not a critical bug.

Cheers,
  Trond

