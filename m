Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWCPS7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWCPS7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCPS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:59:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32896 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964830AbWCPS7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:59:38 -0500
Date: Thu, 16 Mar 2006 19:58:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zachary Amsden <zach@vmware.com>
cc: Rik van Riel <riel@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>,
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
Message-ID: <Pine.LNX.4.61.0603161956570.11776@yvahk01.tjqt.qr>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
 <441642EE.80900@us.ibm.com> <4416460A.2090704@vmware.com>
 <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com> <441658A2.4090905@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> But most importantly, I really don't understand how it is possible to make a
> patch to the Linux kernel and not release it under GPL.
>

If the patch is so ultimatively trivial that there is only a few solutions (one
or two), then there is no use in gpl'ing that flock of patchcode, in which case
I think, it is (or at best should be) public domain. In conjunction with the
patched function, they will/should become GPL.


Jan Engelhardt
-- 
