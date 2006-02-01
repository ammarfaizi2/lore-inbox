Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbWBAGfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbWBAGfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWBAGfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:35:55 -0500
Received: from pat.uio.no ([129.240.130.16]:46034 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030540AbWBAGfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:35:54 -0500
Subject: Re: [BUG] nfs version 2 broken
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
In-Reply-To: <43E0567F.20004@t-online.de>
References: <43E05031.2000107@t-online.de>
	 <1138774519.7861.4.camel@lade.trondhjem.org>  <43E0567F.20004@t-online.de>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 01:35:44 -0500
Message-Id: <1138775744.7875.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.154, required 12,
	autolearn=disabled, AWL 1.66, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 07:34 +0100, Knut Petersen wrote:
> Trond Myklebust schrieb:
> 
> >What kind of server is this that you are using? The above message
> >basically means that it is handing out inodes with a link count of 0.
> >
> >Cheers,
> >  Trond
> >  
> >
> 
> Server:
> =====
> 
> AOpen i915GMm-HFS with Pentium M, linux kernel 2.6.15-git7
> running a system that startet as SuSE 9.2. Nfs-utils are still
> the original 1.0.6, grep -i nfs linuxbuild/.config gives

...and what kind of filesystem are you exporting?

Cheers,
  Trond

