Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTLOS1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLOS1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:27:12 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:5490 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263942AbTLOS1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:27:07 -0500
Date: Mon, 15 Dec 2003 10:30:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rearrange cpumask.h headers in conventional structure
Message-Id: <20031215103000.270955e9.pj@sgi.com>
In-Reply-To: <20031215090331.2ca5a755.akpm@osdl.org>
References: <20031215001045.41b98136.pj@sgi.com>
	<20031215090331.2ca5a755.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Personally, I rather prefer that include/linux/cpumask.h be retained, and
> that it perform the inclusion of <asm/cpumask.h>.

Good idea.  Should have thought of it myself ;).

I'll come up with another patch - probably tomorrow.

Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
