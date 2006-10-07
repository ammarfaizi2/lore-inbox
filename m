Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932842AbWJGUnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbWJGUnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWJGUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:43:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932842AbWJGUnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:43:51 -0400
Date: Sat, 7 Oct 2006 13:43:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: add arch_alloc_page
Message-Id: <20061007134345.0fa1d250.akpm@osdl.org>
In-Reply-To: <20061007105824.14024.85405.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	<20061007105824.14024.85405.sendpatchset@linux.site>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Oct 2006 15:06:04 +0200 (CEST)
Nick Piggin <npiggin@suse.de> wrote:

> Add an arch_alloc_page to match arch_free_page.

umm.. why?
