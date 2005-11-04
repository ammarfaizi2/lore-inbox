Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVKDFOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVKDFOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVKDFOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:14:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161068AbVKDFOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:14:04 -0500
Date: Thu, 3 Nov 2005 21:13:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: introduce mm/util.c for shared functions
Message-Id: <20051103211357.072c5646.akpm@osdl.org>
In-Reply-To: <2.505517440@selenic.com>
References: <2.505517440@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  Add mm/util.c for functions common between SLAB and SLOB.

We should probably add a ppc32-developers-are-weenies warning to string.c
