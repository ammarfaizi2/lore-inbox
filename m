Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVCCOz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVCCOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCCOz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:55:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61873 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261781AbVCCOzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:55:22 -0500
Date: Thu, 3 Mar 2005 06:54:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: neilb@cse.unsw.edu.au, akpm@osdl.org, davej@redhat.com,
       davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303065412.499f2a80.pj@sgi.com>
In-Reply-To: <20050303031047.GA30423@infradead.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<20050303011151.GJ10124@redhat.com>
	<20050302172049.72a0037f.akpm@osdl.org>
	<16934.28536.137910.735002@cse.unsw.edu.au>
	<20050303031047.GA30423@infradead.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote in reply to Neil:
> The point is that it's happening anyway.  See Andres' -as tree which
> is the basis for the Debian vendor kernel. 

Interesting.  We already have a pre-Linus tree, in Andrew's *-mm.
Currently, each distro adds its own set of patches, on top of some
version of a Linus tree.  If we had a blessed post-Linus tree, which the
2.6.<even>.y numbering fits, then we could unify this post-Linus tree
patching to some degree as well, to the general benefit of most everyone
involved.  A bit of holy penguin pee, a chosen spot in the official
numbering scheme, and a good choice of penguin prince as manager of this
release series should be enough to get this going.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
