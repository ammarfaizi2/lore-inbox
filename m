Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271699AbTHMJ0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHMJ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:26:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:34253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271699AbTHMJ0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:26:22 -0400
Date: Wed, 13 Aug 2003 02:26:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "dada1" <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use hugetlb for the text of a program ?
Message-Id: <20030813022650.56cfa680.akpm@osdl.org>
In-Reply-To: <020c01c3617a$f1b7ba00$4600a8c0@edumazet>
References: <20030813013156.49200358.akpm@osdl.org>
	<020c01c3617a$f1b7ba00$4600a8c0@edumazet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"dada1" <dada1@cosmosbay.com> wrote:
>
> The msync() call produces this kernel message (linux-2.6.0-test3)
>  mm/msync.c:52: bad pmd 108000e7.

please post the whole test application, and the command line which was used
to demonstrate this failure.
