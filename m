Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWASHSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWASHSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWASHSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:18:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50619 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161072AbWASHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:18:40 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, davem@davemloft.net,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <20060118230227.5e761d27.akpm@osdl.org>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <20060118.223629.100108404.davem@davemloft.net>
	 <1137653279.27267.15.camel@lade.trondhjem.org>
	 <20060118230227.5e761d27.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 18:18:29 +1100
Message-Id: <1137655109.30084.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 23:02 -0800, Andrew Morton wrote:
> hm.  Why not use $EDITOR's ctags/etags/etc?

Some editors don't have them -- and certainly not for the git trees
pulled from upstream which I keep pristine.

-- 
dwmw2

