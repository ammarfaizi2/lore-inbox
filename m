Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUHIK2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUHIK2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbUHIK2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:28:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:25820 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266460AbUHIK1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:27:07 -0400
Date: Mon, 9 Aug 2004 03:25:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] inode-lock-break.patch, 2.6.8-rc3-mm2
Message-Id: <20040809032523.40250fe8.akpm@osdl.org>
In-Reply-To: <20040809102125.GA12391@elte.hu>
References: <20040809102125.GA12391@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> tested on x86, the patch solves these particular latencies.

On uniprocessor only.   What are we going to do about SMP?

