Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUCAGXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUCAGXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:23:20 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:25573 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262254AbUCAGXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:23:20 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: finding unused globals in the kernel 
In-reply-to: Your message of "Mon, 01 Mar 2004 17:11:12 +1100."
             <5138.1078121472@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Mar 2004 17:22:48 +1100
Message-ID: <5418.1078122168@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 17:11:12 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>namespace.pl below handles all the special cases on kernels from 2.0
>through 2.4.  It needs updating for 2.6 kernels, enjoy.

>my $nm = "/usr/bin/nm -p";	# in case somebody moves nm
>$nm = "/sw/sdev/gcc+bin-ia64/as3-gcc323-bin2.14.90.0.4/bin/nm -p";	# in case somebody moves nm

Oops, testing line left in.  Delete the line that uses /sw/sdev.

