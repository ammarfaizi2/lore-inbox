Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTAFAcV>; Sun, 5 Jan 2003 19:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTAFAcV>; Sun, 5 Jan 2003 19:32:21 -0500
Received: from dp.samba.org ([66.70.73.150]:29923 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265523AbTAFAcU>;
	Sun, 5 Jan 2003 19:32:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: include order for i2c-amd8111 
In-reply-to: Your message of "Mon, 06 Jan 2003 00:13:49 BST."
             <20030105231349.GA8714@elf.ucw.cz> 
Date: Mon, 06 Jan 2003 11:40:20 +1100
Message-Id: <20030106004057.127332C0AA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030105231349.GA8714@elf.ucw.cz> you write:
> Hi!
> 
> It seems all linux then all asm is prefered order...
> 								Pavel

Yes, but not for any great reason, AFAICT.  I think this comes under
the "too trivial" rule (ie.  I'll accept it from the author, but not
someone else).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
