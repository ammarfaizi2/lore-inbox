Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWCQQBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWCQQBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWCQQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:01:46 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:16782 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751324AbWCQQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:01:45 -0500
Date: Fri, 17 Mar 2006 10:56:36 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface
  proposal
To: Christoph Hellwig <hch@infradead.org>
Cc: Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
Message-ID: <200603171058_MC3-1-BADF-9E3F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060315102522.GA5926@infradead.org>

On Wed, 15 Mar 2006 10:25:22 +0000, Christoph Hellwig wrote:

> I agree with Zach here, the Xen hypervisor <-> kernel interface is
> not very nice.  This proposal seems like a step forward althogh it'll
> probably need to go through a few iterations.  Without and actually
> useable opensource hypevisor reference implementation it's totally
> unacceptable, though.

I'd like to see a test harness implementation that has no actual
hypervisor functionality and just implements the VMI calls natively.
This could be used to test the interface and would provide a nice
starting point for those who want to write a VMI hypervisor.


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

