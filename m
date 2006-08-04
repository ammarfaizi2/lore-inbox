Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWHDKCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWHDKCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWHDKCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:02:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39336 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161125AbWHDKCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:02:31 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
In-Reply-To: <44D28985.8050200@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D26D87.2070208@vmware.com>
	 <1154644383.23655.142.camel@localhost.localdomain> <44D2794A.0@vmware.com>
	 <1154647835.23655.161.camel@localhost.localdomain>
	 <44D28985.8050200@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 11:21:25 +0100
Message-Id: <1154686885.23655.198.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 16:40 -0700, ysgrifennodd Zachary Amsden:
> But I think we're running off into the weeds picking nits here..

Your entire proposal started in the weeds anyway.

Every other hypervisor system supported by Linux has a source code
interface on the Linux side that works reliably and compatibly through
versions and releases. The terrible things you claim will happen have
not. IBM have been doing virtualisation for something like forty years.
IBM is not using magic binary blobs. this also leads me to the
conclusion that you are wrong.

Alan

