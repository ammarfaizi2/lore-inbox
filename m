Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUEJUEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUEJUEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEJUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:04:08 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:61752 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261443AbUEJUEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:04:06 -0400
Date: Mon, 10 May 2004 13:03:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: hugepagetlb, include linux/module.h
Message-Id: <20040510130320.573c4d03.pj@sgi.com>
In-Reply-To: <20040510175551.GA1201@MAIL.13thfloor.at>
References: <20040426164822.46bc97cc.pj@sgi.com>
	<20040510175551.GA1201@MAIL.13thfloor.at>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Herbert.  I no longer need to worry about compiling
this particular change - it has propogated far enough that
it's not an issue anymore.

But I will likely consider what you pointed me at for other
work I have in progress ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
