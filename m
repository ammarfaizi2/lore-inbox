Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTG0C4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270656AbTG0C4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:56:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:40404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270655AbTG0C4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:56:33 -0400
Date: Sat, 26 Jul 2003 20:09:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kill annoying submenus in fs/Kconfig
Message-Id: <20030726200903.73d17418.rddunlap@osdl.org>
In-Reply-To: <20030726195544.GA16160@louise.pinerecords.com>
References: <20030726195544.GA16160@louise.pinerecords.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 21:55:44 +0200 Tomas Szepe <szepe@pinerecords.com> wrote:

| Patch against -bk3.
| 
| -- 

Let me begin by saying that I find the menu arrangement (both before
and after this patch) highly subjective.

I.e., there's not necessarily a right or wrong. (RR:)
I.e., in the absence of further input, some maintainer can decide.  :)

Given the above:
I prefer short menus.  I find them more readable, with less clutter.
So I don't mind them the way that they currently are.

OTOH, I don't care strongly either way.  I think that we should
care more about how non-developers use and see 'make *config'
than how kernel developers use and see it.


--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
