Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280618AbRKJLxl>; Sat, 10 Nov 2001 06:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280619AbRKJLxU>; Sat, 10 Nov 2001 06:53:20 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:60942 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S280618AbRKJLxP>; Sat, 10 Nov 2001 06:53:15 -0500
Date: Sat, 10 Nov 2001 11:53:11 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: J Sloan <jjs@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
In-Reply-To: <3BECC7F4.A9EF9E6B@pobox.com>
Message-ID: <Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, J Sloan wrote:

> I have been running the 2.4.15-pre kernels and
> have found an interesting oops. I can reproduce
> it immediately, and reliably, just by issuing an ssh
> command (as a normal user).

I'm seeing the same thing on my gateway, though I haven't
yet found my serial cable to get the oops translated.  I
am back to 2.4.10 for now.

> Hardware: Pentium III 933 w/512 MB RAM
> Red Hat 7.1+ updates

My setup:

K6-200 w/64 MB RAM
Debian Woody
a 3c905B and an RTL-8139

using iptables and transparent proxying (no masq).

>  <0>Kernel panic: Aiee, killing interrupt handler!

I haven't decoded the oops, but I'm certainly seeing this
line.

Matthew.

