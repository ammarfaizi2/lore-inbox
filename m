Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWBXW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWBXW7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWBXW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:59:44 -0500
Received: from pat.uio.no ([129.240.130.16]:33473 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932635AbWBXW7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:59:44 -0500
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kendrick Smith <kmsmith@umich.edu>, Andy Adamson <andros@umich.edu>,
       neilb@cse.unsw.edu.au
In-Reply-To: <200602242149.42735.jesper.juhl@gmail.com>
References: <200602242149.42735.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 17:59:24 -0500
Message-Id: <1140821964.3615.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.098, required 12,
	autolearn=disabled, AWL 1.72, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 21:49 +0100, Jesper Juhl wrote:
> My previous "const static" vs "static const" cleanup missed a single case,
> patch below takes care of it.
> 

I can shepherd that in for 2.6.17 (unless Andrew wants to make it a
2.6.16 priority?).

Cheers,
  Trond

