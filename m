Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUDHBCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 21:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDHBCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 21:02:31 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:32753 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261317AbUDHBCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 21:02:30 -0400
Subject: Re: 2.6.5-mm2 (build error in arch/ia64/kernel/setup.c)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@sgi.com, jbarnes@sgi.com, davidm@hpl.hp.com,
       trini@kernel.crashing.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040407173258.30ada354.akpm@osdl.org>
References: <20040406223321.704682ed.akpm@osdl.org>
	 <20040407090845.GA790466@sgi.com> <20040407105832.39547a4e.akpm@osdl.org>
	 <1081381848.10944.67.camel@bach>  <20040407173258.30ada354.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1081386038.10944.193.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 11:00:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 10:32, Andrew Morton wrote:
> They are taking way too much time which could otherwise
> be spent on all the other broken stuff people like to send me.
> 
> So I've dropped them all.

Yep, that's pretty much what happened last time we tried to fix this,
too.

I'll snarf them and try to break them down into pieces which really can
go in one at a time, and post to lkml for interested people to test...

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

