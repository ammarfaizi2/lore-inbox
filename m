Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752140AbWCNE1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbWCNE1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCNE1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:27:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:11026 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752140AbWCNE1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:27:49 -0500
Message-ID: <4416460A.2090704@vmware.com>
Date: Mon, 13 Mar 2006 20:26:50 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <441642EE.80900@us.ibm.com>
In-Reply-To: <441642EE.80900@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Hi Zach,
>
> A number of the files you posted (including the vmi_spec.txt) have the 
> phrase 'All rights reserved'.  That seems incompatible with the GPL.  
> In particular, it makes it unclear about how one can use the actual 
> vmi spec.
>
> In your next round of patches, could you clarify the actual licensing 
> of the files?

I'm sorry about the legalese.  The patches are patches to the Linux 
kernel, and therefore under GPL v2 by default.  I thought that would be 
implicit.

Zach
