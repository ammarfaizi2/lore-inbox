Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWHCQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWHCQDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWHCQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:03:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21376 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964820AbWHCQDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:03:46 -0400
Date: Thu, 3 Aug 2006 09:05:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803160508.GB11244@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Antonio Vargas (windenntw@gmail.com) wrote:
> If the essence of using virtual machines is precisely that the machine
> acts just as if it was a real hardware one, then we should not need
> any modifications to the kernel. So, it would be much better if the
> hypervirsor was completely transparent and just emulated a native cpu
> and a common native set of hardware, which would then work 100% with
> the native code in the kernel. This keeps the smarts of virtual
> machine management on the hypervisor.

You have missed the point of paravirtualizing x86.
-chris
