Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUEKFWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUEKFWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUEKFWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:22:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:11483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbUEKFWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:22:11 -0400
Date: Mon, 10 May 2004 22:21:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510222143.6ab44a87.akpm@osdl.org>
In-Reply-To: <20040510162012.B3856@infradead.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510162012.B3856@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, one more thing as you're probably sending the i_shared_sem re-
> spinlockification to Linus just about now: as we're renaming the thing
> anyway can we give it a less confusing name like i_mmap_lock?  It's not
> been about shared mapping only for ages.

sure...
