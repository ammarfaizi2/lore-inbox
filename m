Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTAWG1v>; Thu, 23 Jan 2003 01:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTAWG1v>; Thu, 23 Jan 2003 01:27:51 -0500
Received: from dp.samba.org ([66.70.73.150]:1964 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264910AbTAWG1v>;
	Thu, 23 Jan 2003 01:27:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-reply-to: Your message of "Mon, 20 Jan 2003 00:37:50 BST."
             <20030119233750.GA674@elf.ucw.cz> 
Date: Wed, 22 Jan 2003 13:04:50 +1100
Message-Id: <20030123063701.1F7172C2E0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030119233750.GA674@elf.ucw.cz> you write:
> Hi!
> 
> > Everyone loves reimplementing strdup.  Give them a kstrdup (basically
> > from drivers/md).
> 
> I believe it would be better to call it strdup.

No.  Don't confuse people.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
