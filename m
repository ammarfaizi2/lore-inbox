Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUBXBaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUBXBaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:30:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63877 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262124AbUBXB3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:29:46 -0500
Date: Mon, 23 Feb 2004 17:29:42 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: aebr@win.tue.nl, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223172942.5a18528a.pj@sgi.com>
In-Reply-To: <20040224011355.GC6426@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223142215.GB30321@mail.shareable.org>
	<20040223173446.GA2830@pclin040.win.tue.nl>
	<20040223134610.3b6d01a9.pj@sgi.com>
	<20040224011355.GC6426@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see any reason, why one should stick to the limits of some other
> operating systems, when it's not necessary.

If I make it a habit to write portable code, then over the years, I
cause fewer problems for myself and others.  More things "just work". 
I've got scripts that I use that are 10 or 20 years old, and have been
used on all manner of evironments that could not have been anticipated
when the script was first written.

Also my habits need not change - the more things I can do without
thinking, the more thinking I have left over to do something useful.

Somedays, boring beats fine tuning.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
