Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUB0ACt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUB0ACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:02:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:27523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbUB0ACB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:02:01 -0500
Date: Thu, 26 Feb 2004 16:03:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4, sensors broken
Message-Id: <20040226160355.35ced535.akpm@osdl.org>
In-Reply-To: <403E82D8.3030209@gmx.de>
References: <20040225185536.57b56716.akpm@osdl.org>
	<403E82D8.3030209@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
>
> this release made my sensors broken. With mm3 it worked nicely.

Useful info.   If you have time, could you please do a `patch -p1 -R'
of ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/broken-out/bk-i2c.patch
and see if that fixes it up?
