Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUHQFKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUHQFKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUHQFKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:10:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:59332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268108AbUHQFKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:10:00 -0400
Date: Mon, 16 Aug 2004 22:08:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-Id: <20040816220816.1b30fd53.akpm@osdl.org>
In-Reply-To: <200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
	<20040815150635.5ac4f5df.akpm@osdl.org>
	<200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> Here is a fixed fix-build patch, against 2.6.8.1-mm1.

Thanks.  Where do we stand now with getting all this stuff merged up?  Are
the patches in -mm suitable?  Did the controversial blockdev stuff get
cleaned up? (it looks like it did...).
