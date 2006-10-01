Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWJAQjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWJAQjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWJAQjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:39:31 -0400
Received: from xenotime.net ([66.160.160.81]:4028 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751260AbWJAQja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:39:30 -0400
Date: Sun, 1 Oct 2006 09:40:53 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Miguel Ojeda <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
Message-Id: <20061001094053.5d55bf06.rdunlap@xenotime.net>
In-Reply-To: <451F7A59.4020803@s5r6.in-berlin.de>
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>
	<20060930123547.d055383f.rdunlap@xenotime.net>
	<451EE36C.5080002@s5r6.in-berlin.de>
	<20060930144830.eba63268.rdunlap@xenotime.net>
	<653402b90609301545y2d4f162dq824ac360149fc0a7@mail.gmail.com>
	<20060930155250.8cae208b.rdunlap@xenotime.net>
	<451F7A59.4020803@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2006 10:20:41 +0200 Stefan Richter wrote:

> Randy Dunlap wrote:
> > On Sat, 30 Sep 2006 22:45:56 +0000 Miguel Ojeda wrote:
> ...
> >> 	tristate "CFAG12864B LCD Display"
> > 
> > That seems very common to me.
> 
> It is as common as it is wrong. http://en.wikipedia.org/wiki/RAS_Syndrome
> 
> ...
> >> LCDisplay??
> 
> A contraction like LCDisplay, like my suggested lcdisplay for the path
> name, is IMO not suitable for use in normal written language. Use it at
> most for path names where we contract words into one or would write
> lc-display or lc_display.
> 
> > I would continue to use LCD display (small d).
> 
> Still wrong language.
> 
> "LCD" and "LC display" are correct.

whatever.
I've never heard anyone speak of or write about an LC display.

---
~Randy
