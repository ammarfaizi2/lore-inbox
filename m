Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUGBWlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUGBWlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGBWlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:41:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:19116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264961AbUGBWl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:41:29 -0400
Date: Fri, 2 Jul 2004 15:44:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-mm5] perfctr low-level documentation
Message-Id: <20040702154414.31fcfd40.akpm@osdl.org>
In-Reply-To: <200407021919.i62JJh0J004586@harpo.it.uu.se>
References: <200407021919.i62JJh0J004586@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> I'm
> considering Christoph Hellwig's suggestion of moving
> the API back to /proc/<pid>/, but with multiple files
> and open/read/write/mmap instead of ioctl. I believe I
> can make that work, but it would take a couple of days
> to implement properly. Please indicate if you would like
> this change or not.

What would be the advantages of such a change?
