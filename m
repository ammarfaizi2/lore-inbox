Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWITOwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWITOwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWITOwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:52:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64459 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751577AbWITOwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:52:23 -0400
Date: Wed, 20 Sep 2006 16:51:41 +0200 (MEST)
Message-Id: <200609201451.k8KEpfM4014377@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, w@1wt.eu
Subject: Re: Linux 2.4.34-pre3
Cc: davem@davemloft.net, mikpe@it.uu.se, mtosatti@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 17:32:53 +0000, Willy Tarreau wrote:
>I've been a little bit silent and quite busy too. As announced with -pre2,
>here comes -pre3 with only GCC4 fixes. Other fixes I received are minor
>and can wait for -pre4. I really want people to test -pre3 without adding
>any noise to the test. There should be *no* regression at all with existing
>compilers.

I've reviewed the changes and they look fine. So far 2.4.34-pre3
compiled with gcc-4.1.1 runs on i386, x86_64, and ppc32 without
any regressions. I'll test 2.4.34-pre3 on sparc64 this weekend,
but since 2.4.34-pre2 + my gcc4 fixes already runs fine on sparc64,
I don't expect any problems.

/Mikael
