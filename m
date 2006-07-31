Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWGaU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWGaU6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGaU5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:57:39 -0400
Received: from [212.76.92.124] ([212.76.92.124]:16656 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932523AbWGaU5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:57:38 -0400
From: Al Boldi <a1426z@gawab.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead of ramfs
Date: Mon, 31 Jul 2006 23:58:28 +0300
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
References: <200607301808.14299.a1426z@gawab.com> <200607310003.56832.a1426z@gawab.com> <44CE5940.5090700@zytor.com>
In-Reply-To: <44CE5940.5090700@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607312358.29027.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Al Boldi wrote:
> > Well, ramfs has some pitfalls, which doesn't make it suitable for a
> > long-lived rootfs.  OTOH, tmpfs is much more mature, while semantically
> > the same.
> >
> > Being semantically the same, while not exhibiting ramfs pitfalls, makes
> > it suitable to be pushed into the -stable tree, IMHO.
>
> This is total nonsense.

Are you sure?

> They're very different from an implementation standpoint.

Think ext2/3.


Thanks!

--
Al

