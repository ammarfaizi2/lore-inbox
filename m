Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCDHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCDHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 02:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWCDHr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 02:47:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751068AbWCDHr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 02:47:56 -0500
Date: Fri, 3 Mar 2006 23:46:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Van Hensbergen <ericvh@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] v9fs: consolidate trans_sock into trans_fd
Message-Id: <20060303234625.21b84b61.akpm@osdl.org>
In-Reply-To: <200603022230.k22MUmm4017480@hera.kernel.org>
References: <200603022230.k22MUmm4017480@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen <ericvh@hera.kernel.org> wrote:
>
>  here is a new trans_fd.c that replaces the current
>  trans_fd.c and trans_sock.c.  i haven't tested it but
>  the changes are pretty trivial.

I trust that second sentence is obsolete?
