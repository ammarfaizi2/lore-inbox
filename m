Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVGVJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGVJjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGVJhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:37:25 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46465 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261236AbVGVJgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:36:02 -0400
Date: Fri, 22 Jul 2005 11:35:57 +0200 (MEST)
Message-Id: <200507220935.j6M9Zvg3025840@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: drososkourounis@yahoo.gr, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.20, 2.4.21, 2.4.22 , ... does not compile with gcc-3.4.X
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drosos Kourounis wrote:
> This might be a known issue but it is not known to me!
> I tried to compile kernel 2.4.22 under Crux Linux,
> and the compilation stopped in sched.c. I do not have
> to say much to you because it seems a compiler
> problem!
> I guess that it would compile nicely with gcc-3.3.X.
...
> The question is how do I compile a 2.4.X kernel with 
> gcc-3.4.X?

Support for gcc-3.4 was added in 2.4.29. So use a newer
kernel or an older compiler.
