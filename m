Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWGRAtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWGRAtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWGRAtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:49:43 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:63960 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751271AbWGRAtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:49:42 -0400
Date: Mon, 17 Jul 2006 20:49:31 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>,
       "'fsdevel'" <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060718004931.GB8092@ccure.user-mode-linux.org>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu> <20060717204804.GA18516@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717204804.GA18516@harddisk-recovery.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 10:48:04PM +0200, Erik Mouw wrote:
> On Mon, Jul 17, 2006 at 08:13:04AM -0700, Jeff Anderson-Lee wrote:
> > In the past I've wondered why so many experimental FS projects die this
> > death of obscurity in that they only work under FreeBSD or some ancient
> > version of Linux.? I'm beginning to see why that is so:? the Linux core
> > simply changes too fast for it to be a decent FS R&D environment!
> 
> That hasn't been a problem for OCFS2 and FUSE (recently merged), and
> also doesn't seem to be a problem for GFS.

I'm been maintaining a couple (for now) out-of-tree filesystems for
UML, and have seen only minor updates needed over the course of 2.6.

Complaints about interface churn for filesystems (or anything else,
actually, since an architecture, such as UML, is exposed to nearly the
entire kernel) are imcomprehensible to me.

				Jeff
