Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbUBWPiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUBWPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:38:19 -0500
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:52996
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261934AbUBWPiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:38:15 -0500
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Willy Weisz <weisz@vcpc.univie.ac.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kurt Rabitsch <kurt@vcpc.univie.ac.at>
In-Reply-To: <4039FCF8.20008@vcpc.univie.ac.at>
References: <20040221214345.6533eb68.akpm@osdl.org>
	 <1077444724.2944.10.camel@nidelv.trondhjem.org>
	 <4039FCF8.20008@vcpc.univie.ac.at>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077550686.3890.1.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 07:38:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 23/02/2004 klokka 05:15, skreiv Willy Weisz:
> Dear Trond,
> 
> thank you for the fast reply. I chose the first solution (unsetting 
> CONFIG_SECURITY)
> as I don't have local security modules anyhow. and our problem disapeared.
> 
> Is there any reason to nevertheless install your patch?

No: the patch solves just the one problem.

Cheers,
  Trond
