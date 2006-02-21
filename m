Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWBUAzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWBUAzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWBUAzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:55:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161242AbWBUAzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:55:17 -0500
Date: Mon, 20 Feb 2006 16:53:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-Id: <20060220165327.64f15bba.akpm@osdl.org>
In-Reply-To: <20060220201506.GU27946@ftp.linux.org.uk>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43F9B8A9.4000506@reub.net>
	<20060220201506.GU27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> It really would be more useful to pick individual branches
>  	fixes.b8
>  	m32r.b0
>  	m68k.b8
>  	xfs.b8
>  	uml.b1
>  	net.b6
>  	frv.b8
>  	misc.b8
>  	upf.b5
>  	volatile.b0
>  	endian.b8
>  	net-endian.b3

OK...  But it looks like these are liable to be removed, renamed or added
to at the drop of a hat.  I don't know how to keep up with that.
