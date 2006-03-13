Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWCMS5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWCMS5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWCMS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:57:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5588 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750756AbWCMS5M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:57:12 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
Organization: IBM Linux Technology Center
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux =?iso-8859-1?q?virtualization=09interface=09proposal?=
Date: Mon, 13 Mar 2006 12:56:49 -0600
User-Agent: KMail/1.8.3
Cc: Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris Wright <chrisw@osdl.org>, Christopher Li <chrisl@vmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Anne Holler <anne@vmware.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142274398.3023.40.camel@laptopd505.fenrus.org> <4415BA4F.3040307@vmware.com>
In-Reply-To: <4415BA4F.3040307@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603131256.51854.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 12:30, Zachary Amsden wrote:
> It is an advantage for everyone.  It cuts support and certification 
> costs for Linux distributors, software vendors, makes debugging and 
> development easier, and gives hypervisors room to grow while maintaining 
> binary compatibility with already released kernels.

It certainly is good for kernel developers and end-users.

However, it would be a foolish distributor or ISV who tests with one 
hypervisor and decides that covers all hypervisors which implement the same 
interface. So I'm not sure there's any advantage w.r.t. support and 
certification costs.

-- 
Hollis Blanchard
IBM Linux Technology Center
