Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUBIK3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUBIK3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:29:38 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:12222 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264493AbUBIK3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:29:36 -0500
Subject: Re: 2.6.3-rc1-mm1
From: Stian Jordet <liste@jordet.nu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20040209022453.44e7f453.akpm@osdl.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
	 <1076320225.671.7.camel@chevrolet.hybel>
	 <20040209022453.44e7f453.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076322566.671.10.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 11:29:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 09.02.2004 kl. 11.24 skrev Andrew Morton:
> Boggle.  That thing is 1.8MB.
> 
>  163 files changed, 25877 insertions(+), 22424 deletions(-)
> 
> This is the first time that anyone told me that it even existed.  How on
> earth could a patch to a major subsystem grow to such a size in such
> isolation?  When we're at kernel version 2.6.3!
> 
> How mature is this code?  What is its testing status?  What is the size of
> its user base?  Is it available as individual, changelogged patches?
> 
> It would be crazy to simply shut our eyes and slam something of this
> magnitude into the tree.  And it is totally unreasonable to expect
> interested parties to be able to review and understand it.
> 
> Could someone please tell me how this situation came about, and what we can
> do to prevent any reoccurrence?

I don't know more than this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107523583528989&w=2

But I _do_ know that ISDN is non-working for me with 2.6.x kernels
without this patch. 

Best regards,
Stian

