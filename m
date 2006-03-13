Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWCMS0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWCMS0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWCMS0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:26:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40861 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWCMS0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:26:43 -0500
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization
	interface	proposal
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
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
In-Reply-To: <4415B857.9010902@vmware.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
	 <1142273346.3023.38.camel@laptopd505.fenrus.org>
	 <4415B857.9010902@vmware.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 19:26:37 +0100
Message-Id: <1142274398.3023.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The interface we propose we 
> believe is more powerful, and more conducive to performance 
> optimizations while providing significant advantages - most 
> specifically, a single binary image that is properly virtualizable on 
> multiple hypervisors and capable of running on native hardware.

that is mostly an advantage in the binary would though.. less so in the
open source world.


