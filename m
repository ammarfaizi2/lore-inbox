Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWE3C6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWE3C6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWE3C6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:58:33 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36779 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932105AbWE3C6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:58:32 -0400
Date: Tue, 30 May 2006 05:58:27 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Paul Drynoff <pauldrynoff@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/comments: kmalloc man page before 2.6.17 (the fifth
 attempt)
In-Reply-To: <20060529120512.d757a43b.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0605300556010.18303@sbz-30.cs.Helsinki.FI>
References: <20060528111446.55572c6f.pauldrynoff@gmail.com>
 <84144f020605281029q1fa6ed59jb415ffb9a7daeef9@mail.gmail.com>
 <20060529183325.937cea13.pauldrynoff@gmail.com> <20060529120512.d757a43b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 May 2006 18:33:25 +0400 Paul Drynoff wrote:
> > This bugfix patch is added comments to right places and give possibility
> > generate man pages for kmalloc(9) and kzalloc(9).

On Mon, 29 May 2006, Randy.Dunlap wrote:
> Thanks for doing this.  You are right IMO, it was really needed.
> There are more that are needed if you are up to it.

Looks good.  Thanks.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
