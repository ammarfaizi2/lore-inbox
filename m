Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270685AbTGVNqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTGVNqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:46:30 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:5865 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270685AbTGVNno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:43:44 -0400
Date: Tue, 22 Jul 2003 23:57:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-Id: <20030722235700.3f7b8a4b.sfr@canb.auug.org.au>
In-Reply-To: <20030722144218.B5838@flint.arm.linux.org.uk>
References: <20030714084000.J15481@devserv.devel.redhat.com>
	<20030715025252.17ec8d6f.sfr@canb.auug.org.au>
	<20030719183254.GE25703@krispykreme>
	<20030721100819.11584560.sfr@canb.auug.org.au>
	<20030722144218.B5838@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 14:42:18 +0100 Russell King <rmk@arm.linux.org.uk> wrote:
>
> Maybe it'd be a good idea to copy the architecture maintainers.  I'm
> certainly deleting a couple of thousand lkml mails at the moment, so
> its pretty lucky that I just read Anton's message.
> 
> Is ARM broken?

None of the 32 bit architectures are broken.  It was, I would have copied
you, the consolidation work has made me aware of this.  :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
