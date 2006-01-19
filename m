Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWASVDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWASVDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWASVDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:03:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422637AbWASVDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:03:47 -0500
Date: Thu, 19 Jan 2006 13:02:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [resend][patch 5/6] mm: simplify vmscan vs release refcounting
In-Reply-To: <20060119195355.14171.14613.sendpatchset@linux.site>
Message-ID: <Pine.LNX.4.64.0601191302160.3240@g5.osdl.org>
References: <20060119195355.14171.14613.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Jan 2006, Nick Piggin wrote:
>
> Signed-off-by: Nick Piggin <npiggin@suse.de>

ACK, looks ok by me now.

I assume this is still "-mm" material for now.

		Linus
