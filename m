Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbTCZTsC>; Wed, 26 Mar 2003 14:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbTCZTsC>; Wed, 26 Mar 2003 14:48:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54792 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262000AbTCZTr7>; Wed, 26 Mar 2003 14:47:59 -0500
Date: Wed, 26 Mar 2003 11:57:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [BK PULL] PCMCIA changes
In-Reply-To: <20030326193427.B8871@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303261153140.18275-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Mar 2003, Russell King wrote:
> 	bk pull bk://bk.arm.linux.org.uk/linux-2.5-pcmcia
> 
> to include PCMCIA changes listed below.  Patches for each cset will
> follow on LKML.

Pulled.

Russell, since you use BK _and_ you're working on PCMCIA, can you work as 
the middle man for the patches that Dominik has been sending out? They all 
look sane, and the "driver services" socket add/remove abstraction in 
particular looks like something that is needed. I just didn't have time to 
check them out more deeply and test them.

Dominik?

		Linus


