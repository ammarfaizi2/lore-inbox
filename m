Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUFVJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUFVJWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUFVJVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:21:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:33459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261875AbUFVJVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:21:30 -0400
Date: Tue, 22 Jun 2004 02:20:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-Id: <20040622022023.1942fd82.akpm@osdl.org>
In-Reply-To: <20040622091850.GA32160@infradead.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<20040622085901.GA31971@infradead.org>
	<20040622020417.0ec87564.akpm@osdl.org>
	<20040622091219.GA32146@infradead.org>
	<20040622021441.4f6aa13c.akpm@osdl.org>
	<20040622091850.GA32160@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 22, 2004 at 02:14:41AM -0700, Andrew Morton wrote:
> > > Let's ressurect that code instead of doing the syscall approach.
> > 
> > This appears to have come out of the blue.  Please explain why you think
> > this change is needed.
> 
> Just read through all the old perfctr threads.  This was discussed multiple
> times.

Well it didn't register with me and either it didn't register with Mike, or
he rejected the notion.

Please restate the case.
