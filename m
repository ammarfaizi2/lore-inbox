Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUDAGHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUDAGHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:07:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:16847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262703AbUDAGHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:07:52 -0500
Date: Wed, 31 Mar 2004 22:07:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: yusufg@outblaze.com, linux-kernel@vger.kernel.org
Subject: Re: Strange output from exportfs in 2.6.5-rc3-mm1
Message-Id: <20040331220744.5fc69f2d.akpm@osdl.org>
In-Reply-To: <20040331214417.41ea2635.rddunlap@osdl.org>
References: <20040331030439.GA23306@outblaze.com>
	<20040331144031.360c2c3f.rddunlap@osdl.org>
	<20040331213902.147036f3.akpm@osdl.org>
	<20040331214417.41ea2635.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> | You probably didn't have modversions enabled?
> 
>  Not the first time; I did the second time, but when I booted,
>  it rebooted for me during early init (repeatable).  :(
>  (P4 2-proc)  Then I went home.  I can look into this more
>  tomorrow... or is this a known issue?

Not a known issue.  I can take a look if you want to send the .config.

(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)

