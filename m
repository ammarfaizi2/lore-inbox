Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVJ3QCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJ3QCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVJ3QCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:02:25 -0500
Received: from pat.uio.no ([129.240.130.16]:10886 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932094AbVJ3QCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:02:24 -0500
Subject: Re: [-mm patch] fs/namei.c: make path_lookup_create() static
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051030155343.GF4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <20051030155343.GF4180@stusta.de>
Content-Type: text/plain
Date: Sun, 30 Oct 2005 10:58:22 -0500
Message-Id: <1130687902.4044.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.813, required 12,
	autolearn=disabled, AWL 2.00, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 30.10.2005 klokka 16:53 (+0100) skreiv Adrian Bunk:
> On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.14-rc4-mm1:
> >...
> >  git-nfs.patch
> >...
> >  Subsystem trees
> >...
> 
> 
> <--  snip  -->
> 
> 
> This patch makes the needlessly global function path_lookup_create() 
> static.

ACK...

Trond

