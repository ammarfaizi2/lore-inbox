Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSAQNuv>; Thu, 17 Jan 2002 08:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSAQNul>; Thu, 17 Jan 2002 08:50:41 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:18123 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288732AbSAQNud>; Thu, 17 Jan 2002 08:50:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Hans-Christian Armingeon <linux.johnny@gmx.net>
Subject: Re: kernel BUG at slab.c:815!
Date: Thu, 17 Jan 2002 15:51:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16Qvbw-0AB5F2C@fmrl02.sul.t-online.com> <3C45D717.30600@wanadoo.fr>
In-Reply-To: <3C45D717.30600@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16RCvk-0nJWngC@fmrl11.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Januar 2002 20:40 schrieb Pierre Rousselet:
> Hans-Christian Armingeon wrote:
> > VFS: mounted root (ext3 filesystem) readonly
> > devfs: devfs_do_symlink(root): could not append to parent, err: -17
> > change_root: old root has d_count=5

My problem is the oops later, not that message.
>
> it's not a bug, it is a faq
>
> http://www.atnf.csiro.au/~rgooch/linux/docs/devfs.html#faq-messages
>
>
>
>
> Pierre
