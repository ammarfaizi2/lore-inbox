Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVAYQzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVAYQzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVAYQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:55:49 -0500
Received: from mail.suse.de ([195.135.220.2]:44237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261978AbVAYQxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:53:49 -0500
Subject: Re: [patch 1/13] Qsort
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, Andi Kleen <ak@muc.de>,
       Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
In-Reply-To: <1106671920.11449.11.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106672028.9607.33.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 17:53:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 17:52, Trond Myklebust wrote:
> So here's an iconoclastic question or two:
> 
>   Why can't clients sort the list in userland, before they call down to
> the kernel?

Tell that to Sun Microsystems.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

