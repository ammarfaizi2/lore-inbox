Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBWUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUBWUNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:13:16 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:59176 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262030AbUBWUNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:13:11 -0500
Date: Mon, 23 Feb 2004 12:13:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: jamie@shareable.org, hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223121307.36baaf0a.pj@sgi.com>
In-Reply-To: <20040223173446.GA2830@pclin040.win.tue.nl>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223142215.GB30321@mail.shareable.org>
	<20040223173446.GA2830@pclin040.win.tue.nl>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 If there is such nonblank text then for SysVR4,
 SunOS, Solaris, IRIX, HPUX, AIX, Unixware, Linux, OpenBSD, Tru64
 this group consists of precisely one argument.
 FreeBSD, BSD/OS, BSDI split the text

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
