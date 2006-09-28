Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWI1CQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWI1CQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 22:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWI1CQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 22:16:52 -0400
Received: from mail.suse.de ([195.135.220.2]:12947 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965198AbWI1CQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 22:16:51 -0400
From: Neil Brown <neilb@suse.de>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Date: Thu, 28 Sep 2006 12:16:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17691.12418.683406.362383@cse.unsw.edu.au>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: nfds oops in 2.6.17.6
In-Reply-To: message from Ryan Richter on Tuesday September 26
References: <20060926161137.GA27401@tau.solarneutrino.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 26, ryan@tau.solarneutrino.net wrote:
> I got the following oops on an NFS server running vanilla 2.6.17.6 (old,
> I know):

Yes. Old. :-)
This is fixed in more recent kernels.  Definitely in 2.6.17.11.

Thanks anyway.

NeilBrown

