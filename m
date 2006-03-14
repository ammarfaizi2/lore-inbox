Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752094AbWCNMp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbWCNMp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCNMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:45:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752094AbWCNMpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:45:25 -0500
Date: Tue, 14 Mar 2006 07:44:39 -0500 (EST)
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
In-Reply-To: <441658A2.4090905@vmware.com>
Message-ID: <Pine.LNX.4.63.0603140742530.31791@cuia.boston.redhat.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
 <441642EE.80900@us.ibm.com> <4416460A.2090704@vmware.com>
 <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com> <441658A2.4090905@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Zachary Amsden wrote:

> There is a Signed-off-by line on every patch I send out,

You're right.  It was just the first 1/24 that was missing it,
it was there in the second copy.

> But most importantly, I really don't understand how it is possible to 
> make a patch to the Linux kernel and not release it under GPL.

This can really only be done if the person posting the patch
does not have the right to release the code.  This is what the
Signed-off-by lines are for, IIRC.

-- 
All Rights Reversed
