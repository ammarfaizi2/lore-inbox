Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTLVByU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLVByT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:54:19 -0500
Received: from dp.samba.org ([66.70.73.150]:28040 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264284AbTLVByT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:54:19 -0500
Date: Mon, 22 Dec 2003 12:43:15 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Get modpost to work properly with vmlinux in a
 different directory
Message-Id: <20031222124315.46a4268c.rusty@rustcorp.com.au>
In-Reply-To: <1071698186.10795.56.camel@serpentine.pathscale.com>
References: <1071698186.10795.56.camel@serpentine.pathscale.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 13:56:27 -0800
Bryan O'Sullivan <bos@pathscale.com> wrote:

> This is pretty trivial.  The current version of modpost breaks if
> invoked from outside the build tree.  This patch fixes that, and
> simplifies the code a bit while it's at it.

Thanks, I've taken it.  I'll push to Andrew once things have calmed down.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
