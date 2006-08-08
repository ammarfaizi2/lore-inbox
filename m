Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWHHJBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWHHJBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWHHJBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:01:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932560AbWHHJBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:01:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060807155044.a8eee456.rdunlap@xenotime.net> 
References: <20060807155044.a8eee456.rdunlap@xenotime.net>  <20060807154750.5a268055.rdunlap@xenotime.net> 
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       dhowells@redhat.com
Subject: Re: [PATCH -mm 2/5] cachefiles: printk format warning 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 08 Aug 2006 10:01:12 +0100
Message-ID: <17685.1155027672@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rdunlap@xenotime.net> wrote:

> Fix printk format warning(s):
> fs/cachefiles/cf-proc.c:247: warning: int format, different type arg (arg 4)

Applied, thanks.

David
