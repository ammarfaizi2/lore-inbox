Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTJ0AJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTJ0AJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:09:31 -0500
Received: from cambridge.merl.com ([137.203.190.1]:48870 "EHLO
	cambridge.merl.com") by vger.kernel.org with ESMTP id S263686AbTJ0AJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:09:30 -0500
Date: Sun, 26 Oct 2003 19:09:26 -0500
Message-Id: <200310270009.h9R09QW13930@localhost.localdomain>
From: <wsy@merl.com>
To: drees@greenhydrant.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <3F9C5DEC.2080006@greenhydrant.com> (message from David Rees on
	Sun, 26 Oct 2003 15:51:08 -0800)
Subject: Re: compile-time error in 2.6.0-test9
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost> <200310261635.h9QGZTe13121@localhost.localdomain> <20031026171650.GD23792@localhost> <200310262319.h9QNJDr13814@localhost.localdomain> <3F9C5DEC.2080006@greenhydrant.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: David Rees <drees@greenhydrant.com>

   wsy@merl.com wrote:
   > 
   > Now, to figure out why I've got a bunch of unresolved symbols in 
   > when I do "make modules_install".

   You need an updated modutils package.  See the modules section in this 
   document: http://www.codemonkey.org.uk/post-halloween-2.5.txt

OK, that leads to kernel.org/pub/linux/kernel/people/rusty/modules/,
I'll grab the modutils src rpm there and build it.

Thanks!

	-Bill Yerazunis
