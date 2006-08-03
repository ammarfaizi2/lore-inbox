Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWHCWNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWHCWNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 18:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWHCWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 18:13:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4261 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030216AbWHCWNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 18:13:51 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
In-Reply-To: <44D26D87.2070208@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D26D87.2070208@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 23:33:03 +0100
Message-Id: <1154644383.23655.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 14:41 -0700, ysgrifennodd Zachary Amsden:
> Hence my point follows.  Using source compiled with the kernel as a 
> module does nothing to provide a stable interface to the backend 
> hardware / hypervisor implementation.

Could have fooled me. It seems to work for the IBM Mainframe people
really well. 
