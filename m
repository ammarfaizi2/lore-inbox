Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUF3SnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUF3SnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbUF3SnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:43:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:21985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266798AbUF3SnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:43:05 -0400
Date: Wed, 30 Jun 2004 11:41:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "E. Gryaznova" <grev@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [2.6.7-mm4: OOPS] kernel BUG at mm/mmap.c:1793
Message-Id: <20040630114157.59258adf.akpm@osdl.org>
In-Reply-To: <40E2E28E.8010709@namesys.com>
References: <40E2E28E.8010709@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"E. Gryaznova" <grev@namesys.com> wrote:
>
> this is reproducible for me problem:
>  This wilson mmap test (attached) causes the kernel BUG at mm/mmap.c:1793 
>  immediately after running.

I cannot trigger it here.  Does it happen every time?  How much memory does
that machine have?
