Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUJVXzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUJVXzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJVXxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:53:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:34751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269299AbUJVXvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:51:51 -0400
Date: Fri, 22 Oct 2004 16:51:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
In-Reply-To: <1098487053.6029.89.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410221651260.2101@ppc970.osdl.org>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org> 
 <1098484616.6028.80.camel@gaston>  <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
 <1098487053.6029.89.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> This wasn't a cleanup but a bug fix actually ... Oh well, I think we need
> to fix msleep() instead, what do you think ?

I agree.

		Linus
