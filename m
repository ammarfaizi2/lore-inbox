Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWEVXYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWEVXYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWEVXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:24:23 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43651 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751030AbWEVXYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:24:23 -0400
Date: Mon, 22 May 2006 16:24:45 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Ulrich Drepper <drepper@redhat.com>, Dave Jones <davej@redhat.com>,
       linux-stable <stable@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [stable][patch] x86_64: fix number of ia32 syscalls
Message-ID: <20060522232445.GY23243@moss.sous-sol.org>
References: <200605221701_MC3-1-C081-B4B3@compuserve.com> <200605230111.18121.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605230111.18121.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Monday 22 May 2006 22:59, Chuck Ebbert wrote:
> > Recent discussions about whether to print a message about unimplemented
> > ia32 syscalls on x86_64 have missed the real bug: the number of ia32
> > syscalls is wrong in 2.6.16.  Fixing that kills the message.
> 
> There is already a slightly different patch for this in the FF tree.

OK, if there's smth you think is good for -stable, just send it over.

thanks,
-chris
