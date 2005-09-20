Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbVITRhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbVITRhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbVITRhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:37:05 -0400
Received: from [81.2.110.250] ([81.2.110.250]:48620 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932773AbVITRhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:37:04 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, penberg@cs.Helsinki.FI,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20050920101128.70fec697.akpm@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <84144f0205092004187f86840c@mail.gmail.com>
	 <20050920114003.GA31025@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
	 <20050920123149.GA29112@flint.arm.linux.org.uk>
	 <20050920101128.70fec697.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 19:02:41 +0100
Message-Id: <1127239361.7763.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-20 at 10:11 -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >  Since some of the other major contributors to the kernel appear to
> >  also disagree with the statement, I think that the entry in
> >  CodingStyle must be removed.
> 
> Nobody has put forward a decent reason for doing so.  

I've seen five decent reasons so far. Which of the reasons on the thread
do you disagree with and why ?

