Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUDLJO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 05:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDLJO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 05:14:57 -0400
Received: from hacksaw.org ([66.92.70.107]:49585 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id S262750AbUDLJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 05:14:55 -0400
Message-Id: <200404120914.i3C9Enn5032380@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: MNH <tuxracer@gawab.com>
cc: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: multiple kernels 
In-reply-to: Your message of "Mon, 12 Apr 2004 13:03:53 +0530."
             <1081746794.3933.5.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Apr 2004 05:14:49 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>you can copy the .config file from the previous kernel's tree to your
>current kernel tree.

This is true, however, that doesn't mean it will work. There are a lot of 
differences between 2.2 and 2.4.

At very least you must run make oldconfig to bring things forward, and I'm not 
sure you can go backwards, though it might work.

But for all of that, you'll still have to answer lots of questions, and know 
your machine pretty well.

Why do you need the older kernel?
-- 
That which is impossible has become necessary.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


