Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWCPTpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWCPTpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWCPTpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:45:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932699AbWCPTpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:45:42 -0500
Date: Thu, 16 Mar 2006 14:45:13 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
In-Reply-To: <Pine.LNX.4.61.0603162008300.11776@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.63.0603161444460.4458@cuia.boston.redhat.com>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
 <Pine.LNX.4.61.0603162008300.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Jan Engelhardt wrote:

> The code _you_ wrote can be put under any license(s) you want, so in
> the worst case you do not need to rewrite your .c files.

The license might affect which other OSes could link in
the ROM though...

-- 
All Rights Reversed
