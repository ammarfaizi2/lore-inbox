Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUGWMV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUGWMV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 08:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267672AbUGWMV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 08:21:29 -0400
Received: from vena.lwn.net ([206.168.112.25]:35816 "HELO lwn.net")
	by vger.kernel.org with SMTP id S267671AbUGWMV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 08:21:28 -0400
Message-ID: <20040723122127.16468.qmail@lwn.net>
To: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Cc: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org,
       corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs) 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 23 Jul 2004 10:16:37 +0200."
             <20040723081637.93875.qmail@web52903.mail.yahoo.com> 
Date: Fri, 23 Jul 2004 06:21:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So now the world is divided in gods (i.e distributions) and we,
> mere mortals who should pray to the gods to give us a stable
>  kernel ?

This seems to be where a lot of the misunderstanding is.  Did anybody
notice just how divergent the distributors' 2.4 (and prior) kernels were
from the mainline?  If you wanted a kernel with that level of features
and stability, you had to get it from them - or apply hundreds of
patches yourself.

One of the goals of the process now is to get those distributor patches
into the mainline quickly.  My expectation is that the mainline kernel
will be far closer to what the distributors ship than it has been in a
long time, and the mainline will be more stable for it.  Just the
opposite of what a lot of people are saying.

jon
