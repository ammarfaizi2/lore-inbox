Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760155AbWLCXDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155AbWLCXDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760156AbWLCXDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:03:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56210 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1760155AbWLCXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:03:04 -0500
Date: Sun, 3 Dec 2006 23:10:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: Convert kmalloc()+memset() to kzalloc()
Message-ID: <20061203231021.5e5cd949@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612031132220.4502@localhost.localdomain>
References: <Pine.LNX.4.64.0612031132220.4502@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 11:35:49 -0500 (EST)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

> 
>   Convert the single obvious instance in lib/ of kmalloc() + memset()
> to kzalloc().
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Acked-by: Alan Cox <alan@redhat.com>
