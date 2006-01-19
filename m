Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWASHDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWASHDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWASHDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:03:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161053AbWASHDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:03:24 -0500
Date: Wed, 18 Jan 2006 23:02:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: davem@davemloft.net, sfr@canb.auug.org.au, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
Message-Id: <20060118230227.5e761d27.akpm@osdl.org>
In-Reply-To: <1137653279.27267.15.camel@lade.trondhjem.org>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
	<20060119171708.7f856b42.sfr@canb.auug.org.au>
	<20060118.223629.100108404.davem@davemloft.net>
	<1137653279.27267.15.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2006-01-18 at 22:36 -0800, David S. Miller wrote:
>  > I wish there were an exception for function prototypes and definitions.
>  > Why?  So grep actually works.
> 
>  Seconded!

hm.  Why not use $EDITOR's ctags/etags/etc?
