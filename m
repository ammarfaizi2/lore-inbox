Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273168AbTG3SCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273169AbTG3SCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:02:09 -0400
Received: from web20509.mail.yahoo.com ([216.136.226.144]:26201 "HELO
	web20509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S273168AbTG3SCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:02:06 -0400
Message-ID: <20030730180201.78497.qmail@web20509.mail.yahoo.com>
Date: Wed, 30 Jul 2003 11:02:01 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: linux-2.6.0-test1 : modules not working
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: agoddard@purdue.edu, joshk@triplehelix.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030730080115.28fd5d4f.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am curious what is the minimum kernel source tree is
required to build external modules.

I dont want to touch my kernel , i want to make
another directory same 'module_test' and want to copy
only required minimum kernel Source tree with modified
scripts's Makefile and kbuild Makefile to build "Hello
World".

Please help me.

Thanks.


--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> Sure, 2.6 supports external modules (if you mean
> modules that are
> built outside of the kernel source tree), but for
> now you also
> need a full kernel source tree for the build system
> to reference.
> I.e., you can't build an external module without
> having a full
> kernel source tree installed and configured.
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
