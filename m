Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTE0QrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTE0QrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:47:02 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:38889 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263938AbTE0QrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:47:01 -0400
Date: Tue, 27 May 2003 12:58:11 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.33.0305271245290.4448-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, Linus Torvalds wrote:
>... to start the "pre-2.6" series ...

You're kidding, right?  2.5 is no where near ready to be called anything
like "2.6".  With an actual code freeze -- as in fix the shit that's broken,
non-functional, and/or incompletely implemented without adding any more
stuff or rebuilding entire subsystems as opposed to the standard Linus
"code freeze" that's much like a slushy in the 9th level of Hell (assuming
it gets there, it doesn't last long and really does no go) -- 2.5 is about
a year away from having the current code base fully functional and on it's
way to stable.

Count up the number of drivers that haven't been updated to the current
PCI, hotplug, and modules interfaces.

Take a look at the number of arch's that haven't seen much testing (and
in many respects are thus broken)... does anyone have a functional 2.5.70
sparc64 kernel?  I've built several but they're all too big to be booted
(i.e. over 3.5M, and yes, I've turned off everything possible.)

--Ricky


