Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVCAVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVCAVmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCAVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:42:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:32221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262081AbVCAVmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:42:10 -0500
Date: Tue, 1 Mar 2005 13:47:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: christophe@saout.de, agruen@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Message-Id: <20050301134714.055201f8.akpm@osdl.org>
In-Reply-To: <20050301201241.GM3120@waste.org>
References: <2.416337461@selenic.com>
	<200502271417.51654.agruen@suse.de>
	<20050227212536.GG3120@waste.org>
	<1109703983.16139.16.camel@leto.cs.pocnet.net>
	<20050301201241.GM3120@waste.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I'll queue this
> up for after the sort and ACL stuff gets merged.

Whew!

I don't know how long the ACL changes will take to get merged up - is up to
Trond and he had quite a lot of rather robust comments on the first
iteration.

