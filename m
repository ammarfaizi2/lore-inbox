Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUAHAW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAHAW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:22:59 -0500
Received: from dp.samba.org ([66.70.73.150]:63872 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262566AbUAHAW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:22:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Patrick Mochel <mochel@osdl.org>
Subject: Re: s3 sleep: Kill obsolete debugging code 
In-reply-to: Your message of "Fri, 02 Jan 2004 23:46:44 BST."
             <20040102224644.GA466@elf.ucw.cz> 
Date: Thu, 08 Jan 2004 10:51:21 +1100
Message-Id: <20040108002254.E50AB2C2BB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040102224644.GA466@elf.ucw.cz> you write:
> Hi!
> 
> wakeup.S includes some rather nasty, and unneccessary debugging
> code. (It used to try to flush caches/tlbs; now its totally
> useless). Please apply,
> 							Pavel

Removing asm not really trivial unless the author sent it...

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
