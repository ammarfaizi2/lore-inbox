Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWGHBtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWGHBtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGHBtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:49:25 -0400
Received: from xenotime.net ([66.160.160.81]:10162 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751294AbWGHBtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:49:24 -0400
Date: Fri, 7 Jul 2006 18:52:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       paulkf@microgate.com, akpm@osdl.org
Subject: Re: [PATCH] Ref counting for tty_struct and some locking clean up
Message-Id: <20060707185209.939f31b8.rdunlap@xenotime.net>
In-Reply-To: <9e4733910607071847l605c11d3xe67cae38cd54adb4@mail.gmail.com>
References: <9e4733910607071737n1bd01042u92b895edaceb73db@mail.gmail.com>
	<20060707183348.157cc272.rdunlap@xenotime.net>
	<9e4733910607071833r3d2dcea0la7e26a6d0b60bd3@mail.gmail.com>
	<20060707183909.6ea6d05c.rdunlap@xenotime.net>
	<20060707184439.7927721d.rdunlap@xenotime.net>
	<9e4733910607071847l605c11d3xe67cae38cd54adb4@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 21:47:23 -0400 Jon Smirl wrote:

> That's not what I see. Here it is as an attachment.

Thanks, that applies cleanly.

---
~Randy
