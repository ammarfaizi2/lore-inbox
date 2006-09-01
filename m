Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWIANrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWIANrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIANrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:47:12 -0400
Received: from mail.suse.de ([195.135.220.2]:27830 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751405AbWIANrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:47:12 -0400
Date: Fri, 1 Sep 2006 15:47:10 +0200
From: Olaf Kirch <okir@suse.de>
To: Peter Staubach <staubach@redhat.com>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
Message-ID: <20060901134710.GB29574@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043948.27677@suse.de> <44F8359D.40303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F8359D.40303@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 09:29:01AM -0400, Peter Staubach wrote:
> While I'm thinking about it a little more, why not register NFS_ACL with
> portmap/rpcbind?  That would make it pingable via rpcinfo.

I can't say, but I dimly recall that this was intentional, and I
did not want to change this behavior. Andreas Gruenbacher should
know.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
