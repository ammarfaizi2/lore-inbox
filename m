Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWCNFsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWCNFsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWCNFsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:48:52 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:8708 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750927AbWCNFsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:48:51 -0500
Message-ID: <441658A2.4090905@vmware.com>
Date: Mon, 13 Mar 2006 21:46:10 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
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
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <441642EE.80900@us.ibm.com> <4416460A.2090704@vmware.com> <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> It would be very bad if Linus started applying code with
> a dubious license to the kernel, if we want to keep the
> kernel GPL v2.
>   

I believe it says explicitly in our patches that they are licensed under 
GPL v2.

> Having an explicit license and a Signed-off-by: line are
> things to remember with big patch sets.  At the very least
> a Signed-off-by: line.
>   

There is a Signed-off-by line on every patch I send out, with full 
knowledge that this constitutes the work of the author of the said line, 
and full knowledge that this commits the patch into the domain of the 
GPL license.  Sorry for sounding like a lawyer here.  IANAL, but I 
thought that was completely implicit in all patches made to GPL'd 
software.  The signed off by provides accountability and open licensing 
simultaneously.

But most importantly, I really don't understand how it is possible to 
make a patch to the Linux kernel and not release it under GPL.

Zach
