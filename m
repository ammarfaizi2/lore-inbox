Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUBWRex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUBWRex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:34:53 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:48402 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261939AbUBWRet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:34:49 -0500
Date: Mon, 23 Feb 2004 18:34:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Paul Jackson <pj@sgi.com>, hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223173446.GA2830@pclin040.win.tue.nl>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223142215.GB30321@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223142215.GB30321@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: neonova: mailhost.tue.nl 1127; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:22:15PM +0000, Jamie Lokier wrote:
> Paul Jackson wrote:
...
> Such scripts are non-portable because that behaviour isn't universal

There are several websites with information.
I once collected #! info.
See http://homepages.cwi.nl/~aeb/std/hashexclam-1.html

 .. argi, consists of the 0 or 1 or perhaps more arguments to
 the interpreter found in the #! line. Thus, this group is empty
 if there is no nonblank text following the interpreter name in
 the #! line. If there is such nonblank text then for SysVR4,
 SunOS, Solaris, IRIX, HPUX, AIX, Unixware, Linux, OpenBSD, Tru64
 this group consists of precisely one argument.
 FreeBSD, BSD/OS, BSDI split the text following the interpreter name
 into zero or more arguments.

Andries
