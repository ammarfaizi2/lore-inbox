Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUKESH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUKESH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUKESH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:07:28 -0500
Received: from brown.brainfood.com ([146.82.138.61]:4480 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261153AbUKESHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:07:23 -0500
Date: Fri, 5 Nov 2004 12:07:20 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Andrew Morton <akpm@osdl.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm3
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411051205490.1237@gradall.private.brainfood.com>
References: <20041105001328.3ba97e08.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Andrew Morton wrote:

>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
>
> +o_direct-fix-again.patch
>
>  Hopefully get the direct-io fix done right.  Should fix the LVM setup
>  problems people have been reporting.

It does for me.  First mm kernel that has worked for me since 2.6.9 came out.

Now I can run the RT kernels again.

