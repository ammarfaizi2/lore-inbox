Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTGOTcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbTGOTcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:32:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269575AbTGOTcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:32:18 -0400
Date: Tue, 15 Jul 2003 12:39:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [2.5 patch] remove all #include <blk.h>'s
Message-Id: <20030715123935.3500a6cc.akpm@osdl.org>
In-Reply-To: <20030715153458.GK10191@fs.tum.de>
References: <20030715153458.GK10191@fs.tum.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> the attached patch against 2.6.0-test1 (gzip'ed due to it's size) causes
> blk.h to print a warning and removes all uses of blk.h. I've tested the
> compilation in 2.6.0-test1 with a .config that tries to compile as many
> drivers as possible.
>  
> Please either apply it or send a short note that you don't want to apply
> it.

"cleanups" are being vigorously ignored now.  I'd be inclined to let this
one go, thanks.

