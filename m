Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUHUSgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUHUSgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHUSgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:36:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:41362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267624AbUHUSgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:36:45 -0400
Date: Sat, 21 Aug 2004 11:34:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, kaos@sgi.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
Message-Id: <20040821113459.14b9d4ad.akpm@osdl.org>
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
> It's been benchmarked with bonnie++ on 2x and 4x PIII

What were the results?
