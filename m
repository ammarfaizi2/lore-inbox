Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268616AbUGXNyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268616AbUGXNyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268617AbUGXNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 09:54:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:47077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268616AbUGXNyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 09:54:10 -0400
Date: Sat, 24 Jul 2004 09:52:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, christophe@saout.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040724095245.73ca26fe.akpm@osdl.org>
In-Reply-To: <1090672906.8587.66.camel@ghanima>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> So much for cryptoloop.

I think I'd rather add a patch which does printk("cryptoloop will be
removed from Linux on June 30, 2005.  Please migrate to dm-crypt")
