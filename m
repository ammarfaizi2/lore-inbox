Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUEVTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUEVTyc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUEVTyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:54:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:13801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbUEVTya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:54:30 -0400
Date: Sat, 22 May 2004 12:53:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Serice <paul@serice.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iso9660 inodes beyond 4GB
Message-Id: <20040522125357.7d95a4bb.akpm@osdl.org>
In-Reply-To: <40AFAD8E.9080008@serice.net>
References: <40AD2F8A.6030306@serice.net>
	<20040521190602.511d188e.akpm@osdl.org>
	<40AFAD8E.9080008@serice.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Serice <paul@serice.net> wrote:
>
>  > Dumb question: why not simply use a 64-bit type in the inode?
> 
> I wasn't sure how to proceed in this direction, but I'll give it
> another shot.

The operative part of that question was "dumb".  I don't know isofs, so
don't go redoing things on that basis if you think the current code is the
best approach.

>  > It goes 404.  Please just send the patch directly to the mailing
>  > list.
> 
> Sorry.  I didn't think my post(s) made it to the list.  So, I took the
> patch down.

The mail server was sick - please send the patch and its full description.
