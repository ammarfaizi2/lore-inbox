Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbTCVNvM>; Sat, 22 Mar 2003 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbTCVNvM>; Sat, 22 Mar 2003 08:51:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44185
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262759AbTCVNvL>; Sat, 22 Mar 2003 08:51:11 -0500
Subject: Re: PATCH: module for legacy PC9800 ide
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322004736.GA1033@yuzuki.cinet.co.jp>
References: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk>
	 <20030321185905.A7664@infradead.org>
	 <1048278284.5718.87.camel@irongate.swansea.linux.org.uk>
	 <20030322004736.GA1033@yuzuki.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048346051.8911.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 15:14:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 00:47, Osamu Tomita wrote:
> > I agree however - Osamu, can you fix this
> Thanks.
> Could you plese replace patch by this one.
> Some PC-98 has these port, not all PC-98. These ports are connected to
> IDE chip. But driver doesn't use these ports. So I added a warning
> messeage.

I will do

