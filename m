Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWJFWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWJFWGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWJFWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:06:47 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52437 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932641AbWJFWGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:06:46 -0400
Date: Fri, 6 Oct 2006 18:06:33 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Banks <gnb@sgi.com>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] knfsd: Tidyup up meaning of 'buffer size' in nfsd/sunrpc
Message-ID: <20061006220633.GE18026@fieldses.org>
References: <20061005171043.4544.patches@notabene> <1061005071212.6527@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061005071212.6527@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 05:12:12PM +1000, NeilBrown wrote:
> Ok, this patch should fix up the remaining issue with a recent
> set of NFSD patches.  It has been reviewed by Greg, and I'm convinced:-)

It's working for me, thanks.--b.
