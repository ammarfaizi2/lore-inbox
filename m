Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbRGLBLH>; Wed, 11 Jul 2001 21:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbRGLBK5>; Wed, 11 Jul 2001 21:10:57 -0400
Received: from cs.columbia.edu ([128.59.16.20]:47571 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S267394AbRGLBKr>;
	Wed, 11 Jul 2001 21:10:47 -0400
Message-Id: <200107120110.VAA21238@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: jesse@cats-chateau.net
cc: Kip Macy <kmacy@netapp.com>, Paul Jakma <paul@clubi.ie>,
        Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting? 
In-Reply-To: Your message of "Wed, 11 Jul 2001 19:31:22 CDT."
             <01071119453600.23085@tabby> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jul 2001 21:10:47 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-> Jesse Pollard <jesse@cats-chateau.net>  wrote:
> Before you even try switching kernels, first implement a process
> checkpoint/restart. The process must be resumed after a boot using the same
> kernel, with all I/O resumed. Now get it accepted into the kernel.
> 
> Anything else is just another name for "reboot using new kernel".

Exactly.  You may want to take a look at http://www.checkpointing.org


