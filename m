Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJAUIH>; Tue, 1 Oct 2002 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262237AbSJAUIG>; Tue, 1 Oct 2002 16:08:06 -0400
Received: from [198.149.18.6] ([198.149.18.6]:62396 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262215AbSJAUIE>;
	Tue, 1 Oct 2002 16:08:04 -0400
Subject: Re: XFS broken
From: Steve Lord <lord@sgi.com>
To: alan@cotse.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <YWxhbg==.5b10ab174b02db88c19a37e4bddfc948@1033498404.cotse.net>
References: <YWxhbg==.5b10ab174b02db88c19a37e4bddfc948@1033498404.cotse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Oct 2002 15:13:08 -0500
Message-Id: <1033503188.6756.19.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 13:53, Alan Willis wrote:
> 
>   XFS does not compile for me with 2.5.40.  Sorry that I'm not able to give
> more detail, I'll post exact messages later when I have time.
> 
> Just figured it needed pointing out.

We know about it, some infrastructure we were using got pulled out
from under us. There is a patch floating around on the list which
will make it work. This is an interim workaround, performance will
suffer.

Look for this in the subject line:

Re: 2.5.39-bk2 compile failure with CONFIG_XFS_FS=y

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
