Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752393AbWCPQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbWCPQkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWCPQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:40:37 -0500
Received: from xenotime.net ([66.160.160.81]:26602 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752392AbWCPQkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:40:36 -0500
Date: Thu, 16 Mar 2006 08:42:36 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060316084236.4c3b7cd4.rdunlap@xenotime.net>
In-Reply-To: <20060316163621.GA7519@infradead.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<20060316160129.GB6407@infradead.org>
	<20060316082951.58592fdc.rdunlap@xenotime.net>
	<20060316163001.GA7222@infradead.org>
	<20060316083654.d802f3f3.rdunlap@xenotime.net>
	<20060316163621.GA7519@infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 16:36:21 +0000 Christoph Hellwig wrote:

> > > it makes the code longer and harder to read.  there's a reason the core
> > > code doesn't use it, and the periphal code should do the same.
> > 
> > in your opinion.
> 
> of course.  but that it's not used in core code implies this opinion is
> widely shared.

well I'll be happy to leave it up to Andrew to work out.  :)

---
~Randy
