Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUBRK1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUBRK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:27:43 -0500
Received: from s199-007.catv.glattnet.ch ([80.242.199.7]:16002 "EHLO
	hathi.ethgen.de") by vger.kernel.org with ESMTP id S264372AbUBRK1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:27:41 -0500
Date: Wed, 18 Feb 2004 11:27:25 +0100
From: Klaus Ethgen <Klaus@Ethgen.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218102725.GB3394@hathi.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hi,

I hope I can post to the Kernel Mailinglist if I am not subscribed...

The subject is very long done. But I have not found useful answers to
this strange kernel log message.

You wrote:
> It is a TCP bug of the other side.
> 
> You can safely comment out the printk. It would be interesting however
> to find out what the other side is running and yell at the vendor.
> 
> ...
> 
> More likely someone released a new buggy TCP stack to the world.

Well I have the same every night when my backup on the local host is
running. Many of the "kernel: TCP: Treason uncloaked! Peer
192.168.17.2:2988/33016 shrinks window 3035402428:3035418812. Repaired."

But 192.168.17.2 is the same host! So the buggy TCP stack seams to be in
linux kernel.

By the way, I run 2.4.24.

For answers please address me direct as I'm not subscribet to the list.

Regards
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQDM+DJ+OKpjRpO3lAQHdAAgAq9WbDQDVuQVphZp99kH4rqQe2iQZEep/
GDCavKxNTLU5/SkPIFjTJVZM9+KEea9toVE4H+vFfrP5bCfrU2lEbqH4vksPXvxy
JP2sNjFGmdRYaDEKMHYmC8kfcwMsD+sUTOT+KVjH75+ZI74yBSPdAmXK7ca196Dq
8HzQrrj+XtDEJlh93cbRKPmbvcODl1pNiRdZYRk7BtFp+TlSNW19ypE8NQKSLysV
o+ccsXQ99Fb3h5hYFr2Pn7qNp77RCsTeg0NZorA+s4ySuoa68abxIznveZNMsKCx
y87TxdQEZaJbcFPkv8aeRfLK4c1/gKpUQgMeKXgThRMy6cmALFsSdA==
=pY9J
-----END PGP SIGNATURE-----
