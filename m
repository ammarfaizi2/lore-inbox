Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWHDTrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWHDTrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHDTrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:47:42 -0400
Received: from [198.99.130.12] ([198.99.130.12]:34720 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932605AbWHDTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:47:41 -0400
Date: Fri, 4 Aug 2006 15:45:49 -0400
From: Jeff Dike <jdike@addtoit.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-ID: <20060804194549.GA5897@ccure.user-mode-linux.org>
References: <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> <1154667875.11382.37.camel@localhost.localdomain> <20060803225357.e9ab5de1.akpm@osdl.org> <1154675100.11382.47.camel@localhost.localdomain> <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:06:28PM -0700, David Lang wrote:
> I understand this, but for example a UML 2.6.10 kernel will continue to run 
> unmodified on top of a 2.6.17 kernel, the ABI used is stable. however if 
> you have a 2.6.10 host with a 2.6.10 UML guest and want to run a 2.6.17 
> guest you may (but not nessasarily must) have to upgrade the host to 2.6.17 
> or later.

Why might you have to do that?

				Jeff
