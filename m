Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVCOTrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVCOTrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCOTrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:47:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:5330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261838AbVCOTqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:46:07 -0500
Date: Tue, 15 Mar 2005 11:45:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: arjan@infradead.org, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback
 "nobh" option
Message-Id: <20050315114543.09a7e7d9.akpm@osdl.org>
In-Reply-To: <20050315165003.GF21986@parcelfarce.linux.theplanet.co.uk>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
	<20050314180917.07f7ac58.akpm@osdl.org>
	<1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com>
	<1110903996.6290.73.camel@laptopd505.fenrus.org>
	<20050315165003.GF21986@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
> Can we get rid of the "nobh" ext2 mount option too so other people don't
>  get mislead into thinking this is a good idea?

What's wrong with ext2 -o nobh??
