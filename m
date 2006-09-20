Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWITQ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWITQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWITQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:59:22 -0400
Received: from 1wt.eu ([62.212.114.60]:6163 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751891AbWITQ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:59:21 -0400
Date: Wed, 20 Sep 2006 18:41:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre3
Message-ID: <20060920164112.GA8142@1wt.eu>
References: <200609201451.k8KEpfM4014377@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609201451.k8KEpfM4014377@alkaid.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 04:51:41PM +0200, Mikael Pettersson wrote:
> On Tue, 19 Sep 2006 17:32:53 +0000, Willy Tarreau wrote:
> >I've been a little bit silent and quite busy too. As announced with -pre2,
> >here comes -pre3 with only GCC4 fixes. Other fixes I received are minor
> >and can wait for -pre4. I really want people to test -pre3 without adding
> >any noise to the test. There should be *no* regression at all with existing
> >compilers.
> 
> I've reviewed the changes and they look fine. So far 2.4.34-pre3
> compiled with gcc-4.1.1 runs on i386, x86_64, and ppc32 without
> any regressions. I'll test 2.4.34-pre3 on sparc64 this weekend,
> but since 2.4.34-pre2 + my gcc4 fixes already runs fine on sparc64,
> I don't expect any problems.

Thanks for your tests Mikael. FYI, it works fine for me on my ultra5
(sparc64 UP) and ultra60 (sparc64 SMP).

> /Mikael

Regards,
Willy

