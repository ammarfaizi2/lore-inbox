Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266322AbUG0FLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUG0FLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUG0FKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:10:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:64421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266322AbUG0FKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:10:42 -0400
Date: Mon, 26 Jul 2004 22:07:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (update) Process Aggregates (PAGG) for 2.6.7
Message-Id: <20040726220751.3a71fc86.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.53.0407221557260.474995@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0407221557260.474995@subway.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Jacobson <erikj@subway.americas.sgi.com> wrote:
>
> Attached is the PAGG patch for kernel 2.6.7.  Some may recall I posted an
>  earlier PAGG patch for 2.6.7.  This version has improved handling for
>  the init function pointer functionality introduced earlier.
> 
>  We'd be very interested in seeing this be accepted in to the kernel.  If
>  there is anything we should adjust to make it more likely to be accepted,
>  please reply.

Seems straightforward enough, but until we've decided to merge
features which actually _use_ the mechanism, I'd be reluctant
to send any of this Linuswards.
