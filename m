Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317294AbSFCGso>; Mon, 3 Jun 2002 02:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317295AbSFCGsn>; Mon, 3 Jun 2002 02:48:43 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:63652 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317294AbSFCGsn>; Mon, 3 Jun 2002 02:48:43 -0400
Date: Mon, 3 Jun 2002 16:49:05 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-Id: <20020603164905.1a120598.rusty@rustcorp.com.au>
In-Reply-To: <3CF5758D.9080907@mandrakesoft.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002 20:42:53 -0400
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> One thing I would like to see is building where builddir != srcdir.

Hmm, I always do:
	cp -al linux-2.5.20 working-2.5.20-hotplug
	cd working-2.5.20-hotplug...

But this only works if you have an editor which breaks hardlinks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
