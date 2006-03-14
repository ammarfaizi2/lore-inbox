Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752172AbWCNEbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbWCNEbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWCNEbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:31:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752172AbWCNEbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:31:12 -0500
Date: Mon, 13 Mar 2006 23:30:42 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Zachary Amsden <zach@vmware.com>
cc: Anthony Liguori <aliguori@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
In-Reply-To: <4416460A.2090704@vmware.com>
Message-ID: <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
 <441642EE.80900@us.ibm.com> <4416460A.2090704@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Zachary Amsden wrote:
> Anthony Liguori wrote:

> > In your next round of patches, could you clarify the actual licensing of the
> > files?
> 
> I'm sorry about the legalese.  The patches are patches to the Linux kernel,
> and therefore under GPL v2 by default.  I thought that would be implicit.

It would be very bad if Linus started applying code with
a dubious license to the kernel, if we want to keep the
kernel GPL v2.

Having an explicit license and a Signed-off-by: line are
things to remember with big patch sets.  At the very least
a Signed-off-by: line..

-- 
All Rights Reversed
