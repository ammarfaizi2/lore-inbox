Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWDCRsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWDCRsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWDCRsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:48:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60802 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964819AbWDCRsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:48:17 -0400
Subject: Re: lkml traffic (was:: [PATCH] unify PFN_* macros)
From: Dave Hansen <haveblue@us.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060403083940.a9dff4a3.rdunlap@xenotime.net>
References: <20060323162459.6D45D1CE@localhost.localdomain>
	 <20060403124916.GA14044@linux-mips.org>
	 <20060403083940.a9dff4a3.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 10:48:02 -0700
Message-Id: <1144086482.9731.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 08:39 -0700, Randy.Dunlap wrote:
> On Mon, 3 Apr 2006 13:49:16 +0100 Ralf Baechle wrote:
> 
> > How about posting such stuff to linux-arch?  No sane person follows l-k.
> 
> Can we do anything about lkml?  It "doesn't scale."

Except for long plane rides, I only read it these days through filters.
Those filters watch certain people and patches that modify certain
files.  That should work pretty well, especially for those people that
really care about isolated bits of code in the kernel like certain
drivers or architectures.

I'm in awe of those who can really keep up with LKML.

-- Dave

