Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSHAVMR>; Thu, 1 Aug 2002 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHAVMQ>; Thu, 1 Aug 2002 17:12:16 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:46347 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317072AbSHAVMQ>; Thu, 1 Aug 2002 17:12:16 -0400
Date: Thu, 1 Aug 2002 23:15:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.33.0208011348430.12015-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208012313200.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Aug 2002, Linus Torvalds wrote:

> Go read the standards. Some IO is not interruptible.

Which standard? Which "some IO"?
Some programs rely on interruptable IO, e.g. to implement timeouts.
/me is confused.

bye, Roman

