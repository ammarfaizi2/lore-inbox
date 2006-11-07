Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753767AbWKGWTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbWKGWTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbWKGWTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:19:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752969AbWKGWTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:19:10 -0500
Date: Tue, 7 Nov 2006 14:16:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 2/5] kevent: Core files.
Message-Id: <20061107141657.b2378218.akpm@osdl.org>
In-Reply-To: <11629182482529@2ka.mipt.ru>
References: <1162918248891@2ka.mipt.ru>
	<11629182482529@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 19:50:48 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> This patch includes core kevent files:
>  * userspace controlling
>  * kernelspace interfaces
>  * initialization
>  * notification state machines

I fixed up all the rejects, but your syscall numbers changed.  Please
always raise patches against the latest kernel.
