Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTDIBjU (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDIBjU (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:39:20 -0400
Received: from dp.samba.org ([66.70.73.150]:43919 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262683AbTDIBjT (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:39:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Tue, 08 Apr 2003 00:39:46 -0400."
             <3E925292.8060104@pobox.com> 
Date: Wed, 09 Apr 2003 10:46:03 +1000
Message-Id: <20030409015058.9EF0D2C08F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E925292.8060104@pobox.com> you write:
> You may take a look at "kcompat" for further examples. 
> http://sf.net/projects/gkernel/   I provide an example of how to get a 
> net driver from 2.4 running under 2.2, such that the 2.4 driver 
> -appears- to be completely free of compatibility glue.

Interesting.  How is this related to the older linux/compatmac.h?
Have you thought of actually integrating a 2.4<->2.6 version once
2.6.0 is out?

Thanks for the pointer!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
