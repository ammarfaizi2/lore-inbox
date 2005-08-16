Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVHPFRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVHPFRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVHPFRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:17:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31902 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965106AbVHPFRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:17:12 -0400
Date: Tue, 16 Aug 2005 01:16:53 -0400
From: Dave Jones <davej@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: obsolete modparam change busted.
Message-ID: <20050816051653.GC11618@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050808184955.GA18779@redhat.com> <1123560076.13481.37.camel@localhost.localdomain> <20050813182748.GG26633@redhat.com> <1124167150.6292.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124167150.6292.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 02:39:10PM +1000, Rusty Russell wrote:
 > On Sat, 2005-08-13 at 14:27 -0400, Dave Jones wrote:
 > > We're now munching the end of the boot command line it seems.
 > 
 > Wow, if we had testcases in the kernel source, I would not have to keep
 > rewriting them (badly) every time I touched this code.

Maybe someone should write a userspace test harness for kernel code. :-P

 > Throw away that stupid patch, apply this stupid patch.

I'll throw it into the Fedora kernel tomorrow, and re-test.
Thanks for chasing this so quickly.

		Dave

