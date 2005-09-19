Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVISJWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVISJWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVISJWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:22:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932399AbVISJWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:22:38 -0400
Date: Mon, 19 Sep 2005 02:21:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: reiser@namesys.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-Id: <20050919022153.57ad808f.akpm@osdl.org>
In-Reply-To: <20050919090145.GA15607@infradead.org>
References: <432AFB44.9060707@namesys.com>
	<200509171415.50454.vda@ilport.com.ua>
	<200509180934.50789.chriswhite@gentoo.org>
	<200509181321.23211.vda@ilport.com.ua>
	<20050918102658.GB22210@infradead.org>
	<b14e81f0050918102254146224@mail.gmail.com>
	<1127079524.8932.21.camel@localhost.localdomain>
	<432E4786.7010001@namesys.com>
	<20050919090145.GA15607@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Before you should probably
>  fix up various bits I wrote up and especialy make sure to get rid of
>  all duplication of generic I/O code or explain in detail why you need it
>  and fix your own implementations.

Yup, thanks.  I've made a record of your comments in the changelog for
-mm's reiser4-only.patch.
