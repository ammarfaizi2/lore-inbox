Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbTILEJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbTILEJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:09:21 -0400
Received: from dp.samba.org ([66.70.73.150]:12234 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261654AbTILEJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:09:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Harry Brueckner <hb@o-d.de>, linux-kernel@vger.kernel.org
Subject: Re: devfs with 2.6.0-test4 kernel 
In-reply-to: Your message of "Thu, 11 Sep 2003 04:54:19 -0400."
             <3F60383B.6030406@cornell.edu> 
Date: Fri, 12 Sep 2003 13:39:09 +1000
Message-Id: <20030912040920.8DAA52C019@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F60383B.6030406@cornell.edu> you write:
> 
> > Any ideas what might be wrong?
> 
> Modprobe is too verbose when it comes to devfs failures.
> This is known issue, and Rusty Russel has a patch for modutils, but he 
> hasn't merged it yet, I think (or has he?).

I've just released 0.9.14.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
