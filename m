Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVAMImw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVAMImw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVAMImw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:42:52 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:13485 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261298AbVAMImu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:42:50 -0500
Date: Thu, 13 Jan 2005 09:42:50 +0100
From: Voluspa <lista1@telia.com>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11-rc1
Message-Id: <20050113094250.706fd9a8.lista1@telia.com>
In-Reply-To: <20050113012159.GB15008@hygelac>
References: <20050112095238.32a89245.lista1@telia.com>
	<20050113021328.137435b8.lista1@telia.com>
	<20050113012159.GB15008@hygelac>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005 19:21:59 -0600
Terence Ripperda wrote:

> change_page_attr has a book-keeping bug that surprisingly hasn't
> caused problems until recently (on my todo list is to track down what
> caused this problem to suddenly start triggering).

If it can help, I'm writing this on a 2.6.10-bk14 kernel. So it's just
the final bits going into 2.6.11-rc1 that pushed the bug on. At
least on my machine.

Can't find any incremental bk14->rc1 to finalize that statement, though.

Ok kernels, from 2.6.10, that I've compiled and run now is: -bk7, -bk11,
-bk13 and -bk14.

-- 
Mvh
Mats Johannesson
