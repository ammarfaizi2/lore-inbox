Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWEZHER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWEZHER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWEZHER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:04:17 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:20621 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751309AbWEZHEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:04:15 -0400
Message-ID: <348627053.08248@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:04:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] radixtree: hole scanning functions
Message-ID: <20060526070416.GB5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469537.15678@ustc.edu.cn> <20060525091946.2b57840f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525091946.2b57840f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:19:46AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > Introduce a pair of functions to scan radix tree for hole/empty item.
> >
> 
> There's a userspace radix-tree test harness at
> http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz.
> 
> If/when these new features are merged up, it would be good to have new
> testcases added to that suite, please.
> 
> In the meanwhile you may care to develop those tests anwyway, see if you
> can trip up the new features.

Handy tool.

I'll update it with the newly introduced functions, and write
corresponding test cases.

Thanks,
Wu
