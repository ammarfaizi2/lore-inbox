Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319029AbSIJFhC>; Tue, 10 Sep 2002 01:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIJFhC>; Tue, 10 Sep 2002 01:37:02 -0400
Received: from dp.samba.org ([66.70.73.150]:26497 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319029AbSIJFhB>;
	Tue, 10 Sep 2002 01:37:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 - EXPORT_SYMBOL(reparent_to_init) for module build 
In-reply-to: Your message of "Mon, 09 Sep 2002 17:21:11 MST."
             <20020909172111.A19949@eng2.beaverton.ibm.com> 
Date: Tue, 10 Sep 2002 15:14:39 +1000
Message-Id: <20020910054147.C24F42C0CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020909172111.A19949@eng2.beaverton.ibm.com> you write:
> With 2.5.34, in order to build a module that calls daemonize(), I had to 
> export reparent_to_init:

Why?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
