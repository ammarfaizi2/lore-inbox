Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRLWS2a>; Sun, 23 Dec 2001 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLWS2U>; Sun, 23 Dec 2001 13:28:20 -0500
Received: from mail50-s.fg.online.no ([148.122.161.50]:58818 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S283269AbRLWS2R>; Sun, 23 Dec 2001 13:28:17 -0500
Message-Id: <200112231828.TAA29222@mail50.fg.online.no>
Content-Type: text/plain; charset=US-ASCII
From: Svein Ove Aas <svein@crfh.dyndns.org>
Reply-To: svein.ove@aas.no
To: linux-kernel@vger.kernel.org
Subject: Re: port-based bandwidth throttling
Date: Sun, 23 Dec 2001 19:28:00 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112231543.fBNFh0C28576@orf.homelinux.org>
In-Reply-To: <200112231543.fBNFh0C28576@orf.homelinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 23. December 2001 16:43, Leigh Orf wrote:
> Is it possible to throttle the bandwidth of traffic using a specific
> port or range of ports? Say I want to limit the total outgoing traffic
> on ports 12345-12456 to 100 kB/s. Or limit outgoing ftp-data (port
> 20) traffic to 200 kB/s (not using ftp software throttling). Is there
> a kernel-based way to do tihs? I've looked at shapecfg but the docs
> didn't help me much, and what I've seen of the QoS stuff goes over my
> head. Some examples/pointers would be great.
>
> Leigh Orf

You want to read the Linux Advanced Routing & Traffic Control HOWTO, at 
http://ds9a.nl/lartc/

- --
Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JiIzV16YNKh+HBMRAs2SAJ46Tjnn0Gon+JS3NSj92Aa8FJBywwCeINMs
Pl2UhDJe6Z2jQxwqsSSTagY=
=uGbb
-----END PGP SIGNATURE-----
