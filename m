Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUHUSht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUHUSht (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHUSht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:37:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:43410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267626AbUHUShn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:37:43 -0400
Date: Sat, 21 Aug 2004 11:35:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, kaos@sgi.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
Message-Id: <20040821113556.368c7be5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
>
> the focus of this patch is for reduced kernel image size

By how much does it reduce kernel image size?
