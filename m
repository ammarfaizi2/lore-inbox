Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUBIKWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUBIKWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:22:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:44170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264472AbUBIKWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:22:24 -0500
Date: Mon, 9 Feb 2004 02:24:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-Id: <20040209022453.44e7f453.akpm@osdl.org>
In-Reply-To: <1076320225.671.7.camel@chevrolet.hybel>
References: <20040209014035.251b26d1.akpm@osdl.org>
	<1076320225.671.7.camel@chevrolet.hybel>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet <liste@jordet.nu> wrote:
>
> man, 09.02.2004 kl. 10.40 skrev Andrew Morton:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
> 
> Pretty, pretty please take Karstein Keil's big isdn update from
> 
> ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6
> 

Boggle.  That thing is 1.8MB.

 163 files changed, 25877 insertions(+), 22424 deletions(-)

This is the first time that anyone told me that it even existed.  How on
earth could a patch to a major subsystem grow to such a size in such
isolation?  When we're at kernel version 2.6.3!

How mature is this code?  What is its testing status?  What is the size of
its user base?  Is it available as individual, changelogged patches?

It would be crazy to simply shut our eyes and slam something of this
magnitude into the tree.  And it is totally unreasonable to expect
interested parties to be able to review and understand it.

Could someone please tell me how this situation came about, and what we can
do to prevent any reoccurrence?


