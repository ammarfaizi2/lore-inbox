Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286111AbRLTFVA>; Thu, 20 Dec 2001 00:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286123AbRLTFUu>; Thu, 20 Dec 2001 00:20:50 -0500
Received: from [139.84.194.100] ([139.84.194.100]:38554 "EHLO
	eclipse.pheared.net") by vger.kernel.org with ESMTP
	id <S286111AbRLTFUp>; Thu, 20 Dec 2001 00:20:45 -0500
Date: Thu, 20 Dec 2001 00:19:41 -0500 (EST)
From: Kevin <kevin@pheared.net>
To: Jason Czerak <Jason-Czerak@Jasnik.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestions for linux security patches
In-Reply-To: <1008794926.842.6.camel@neworder>
Message-ID: <Pine.GSO.4.40.0112200017280.1846-100000@eclipse.pheared.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 2001, Jason Czerak grunted something like:

[Jason-] I'm running linux 2.4.16, and I"m looking to the best possibly kernel
[Jason-] patch to harden things up a bit. Primarly I wish to have what is in
[Jason-] openwall's and grsecurity's patches is the buffer oveflow protection,
[Jason-] but I'm unable to use the openwall patch because it only support 2.2.X
[Jason-] kernels ATM. I applied the grsecurity patch but for some reason when
[Jason-] running mozilla as non-root, the GUI for mozilla is all messed up (and I
[Jason-] enabled sysctl support so nothing was enabled by default except stuff
[Jason-] that isn't able to use sysctl).

Has anyone tried the NSA linux security setup?  I've looked it over but
haven't gone so far as to actually run it.

BTW, mozilla gets F-ed up for me sometimes when I foolishly run Netscape 6
and NS6 rewrites several of the config files.  Usually rm'ing ~/.mozilla
does it.  Could be very unrelated though.

-[ kevin@pheared.net                 devel.pheared.net ]-
-[ Rather be forgotten, than remembered for giving in. ]-
-[ ZZ = g ^ (xb * xa) mod p      g = h^{(p-1)/q} mod p ]-

