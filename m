Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVBPQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVBPQSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVBPQSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:18:42 -0500
Received: from news.suse.de ([195.135.220.2]:31129 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261908AbVBPQRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:17:48 -0500
Subject: Re: [patch 10/13] Solaris nfsacl workaround
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108488547.10073.39.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.889966000@blunzn.suse.de>
	 <1108488547.10073.39.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1108570666.30082.118.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Feb 2005 17:17:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 18:29, Trond Myklebust wrote:
> lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > Solaris nfsacl workaround
> 
> NACK. No hacks.

Well, I'm not in the position to fix Solaris. It would be possible to
implement NFSACL for NFSv2 (Solaris has it), but I doubt that we need
it. Your NACK probably means we'll have to carry it around as a vendor
patch.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

