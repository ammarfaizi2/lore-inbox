Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUBXBhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUBXBdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:33:54 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29833 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262175AbUBXBcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:32:48 -0500
Date: Mon, 23 Feb 2004 17:32:46 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223173246.5998e0a1.pj@sgi.com>
In-Reply-To: <20040224001313.GA6426@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223202524.GC13914@hobbes>
	<20040223140027.5c035157.pj@sgi.com>
	<20040224001313.GA6426@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I really can't see any problem with such a shell...

I think we are agreeing on the technical details.

But not on the relative weight of the potential problems
versus the value of the change you propose.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
