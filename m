Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWG0RPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWG0RPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWG0RPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:15:47 -0400
Received: from mail.ccur.com ([66.10.65.12]:24796 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1751800AbWG0RPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:15:47 -0400
Subject: Re: [PATCH] documentation: Documentation/initrd.txt
From: Tom Horsley <tom.horsley@ccur.com>
To: 7eggert@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1G69M4-0001Um-Jg@be1.lrz>
References: <6DfYt-7zU-49@gated-at.bofh.it>  <E1G69M4-0001Um-Jg@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 13:15:46 -0400
Message-Id: <1154020546.5166.35.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 19:08 +0200, Bodo Eggert wrote:
> > I spent a long time the other day trying to examine an initrd
> > image on a fedora core 5 system because the initrd.txt file
> > is apparently obsolete. Here is a patch which I hope
> > will reduce future confusion for others.
> 
> Your documentation is technically wrong, and there is a better
> explanation:

I find it easy to believe my document is wrong, but looking at
the Documentation/filesystems/ramfs-rootfs-initramfs.txt file
would never have led me to believe that the initrd.img file
was related in any way. The ramfs-rootfs-initramfs.txt
file describes the the archive as being built into the
kernel, so it needs updating too I guess (and fedora
should change the name of the initrd files to be
initramfs files so I'll look for documentation in the right
place :-).
