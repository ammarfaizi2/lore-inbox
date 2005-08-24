Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVHXBOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVHXBOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVHXBOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:14:42 -0400
Received: from ozlabs.org ([203.10.76.45]:17090 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750910AbVHXBOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:14:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17163.51700.805599.487962@cargo.ozlabs.ibm.com>
Date: Wed, 24 Aug 2005 11:14:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@www.linux.org.uk>
Cc: torvalds@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (20/43) Kconfig fix (ppc32 SMP dependencies)
In-Reply-To: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
References: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:

> ppc SMP is supported only for 6xx/POWER3/POWER4 - i.e. ones that have
> PPC_STD_MMU.  Dependency fixed.
> 
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Acked-by: Paul Mackerras <paulus@samba.org>
