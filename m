Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTIMR7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTIMR7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:59:30 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:57755 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261815AbTIMR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:59:29 -0400
Subject: Re: People, not GPL  [was: Re: Driver Model]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Timothy Miller <miller@techsource.com>,
       David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0309131614550.2634-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0309131614550.2634-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063475882.8519.28.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 18:58:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 15:18, Geert Uytterhoeven wrote:
> Unfortunately it seems to be almost impossible to design a license that forces
> you to play according to the rules of fair play, and doesn't have any
> loopholes or grey areas.

Fair play is awfully hard to define. Fair use likewise. Currently almost
all countries legal systems have a clear notion of "derived work", and
copyright (unlike patents) extends no further. That limits how far the
GPL can extend, but its the same line in the sand (well fuzzy patch in
the sand in truth) that stops a lot of other things you wouldnt like.
Which and what modules count as derivative works is a lawyer question
and not it seems a trivial one.

Patents do extend beyond just the derived work and since Linux contains
patented material with rights granted for GPL use as per the GPL(but not
for non GPL use) there is a murky area around modules and patents - one
example of the issues that raises being RTLinux.

Folks using binary modules may also find third party software licenses
invalid (eg the OpenMotif one)


