Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264573AbUD1Bcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbUD1Bcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUD1Bcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:32:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10296 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264573AbUD1Bcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:32:53 -0400
Date: Tue, 27 Apr 2004 18:31:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: wli@holomorphy.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix cpu iterator on empty bitmask
Message-Id: <20040427183135.6250f7bc.pj@sgi.com>
In-Reply-To: <1083115347.30987.202.camel@bach>
References: <1083109972.2150.124.camel@bach>
	<20040428000511.GU743@holomorphy.com>
	<1083115347.30987.202.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Agreed, I'm pretty sure Paul's work doesn't make this mistake, but this
> is a trivial patch for a real big which is causing oopses today.
>
> Linus, please apply...

agreed

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
