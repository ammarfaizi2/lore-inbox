Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUGITEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUGITEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUGITEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:04:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:8168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265398AbUGITEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:04:49 -0400
Date: Fri, 9 Jul 2004 12:03:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-Id: <20040709120336.74e57ceb.akpm@osdl.org>
In-Reply-To: <20040709140630.GA27350@wavehammer.waldi.eu.org>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank <bastian@waldi.eu.org> wrote:
>
>  The attached patch marks IPv6 support for QETH broken, it is known to
>  need an extra patch to compile which was submitted one year ago but
>  never accepted.

Well fixing it would be the preferable approach.  Where is the "extra
patch" and what was the complaint?

