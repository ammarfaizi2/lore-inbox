Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161414AbWHDUwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161414AbWHDUwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWHDUwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:52:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32897 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161409AbWHDUwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:52:00 -0400
Date: Fri, 4 Aug 2006 13:52:30 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru, Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
Message-ID: <20060804205230.GL2654@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D3B0F0.2010409@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Maybe someday Xen and VMware can share the same ABI interface and both 
> use a VMI like layer.  But that really is a separate and completely 
> orthogonal question.  Paravirt-ops makes any approach to integrating 
> hypervisor awareness into the kernel cleaner by providing an appropriate 
> abstract interface for it.

Thanks a lot for clarifying, Zach ;-)
-chris
