Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbRCCB2a>; Fri, 2 Mar 2001 20:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRCCB2U>; Fri, 2 Mar 2001 20:28:20 -0500
Received: from tux.creighton.edu ([147.134.2.47]:18094 "EHLO tux.creighton.edu")
	by vger.kernel.org with ESMTP id <S130210AbRCCB2K>;
	Fri, 2 Mar 2001 20:28:10 -0500
Date: Fri, 2 Mar 2001 19:27:55 -0600 (CST)
From: Phil Brutsche <pbrutsch@tux.creighton.edu>
To: "David S. Miller" <davem@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 TCP window shrinking
In-Reply-To: <15008.6084.410042.53699@pizda.ninka.net>
Message-ID: <Pine.LNX.4.32.0103021908230.25035-100000@tux.creighton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A long time ago, in a galaxy far, far way, someone said...

>
> Jim Woodward writes:
>  > This has probably been covered but I saw this message in my logs and
>  > wondered what it meant?
>  >
>  > TCP: peer xxx.xxx.1.11:41154/80 shrinks window 2442047470:1072:2442050944.
>  > Bad, what else can I say?
>  >
>  > Is it potentially bad? - Ive only ever seen it twice with 2.4.x
>
> We need desperately to know exactly what OS the xxx.xxx.1.14 machine
> is running.  Because you've commented out the first two octets, I
> cannot check this myself using nmap.

I'm seeing similar messages on a web server running 2.4.2.

Some of hosts I've seen it with are:

205.188.208.172
209.240.220.172
209.240.220.173
209.240.220.174
209.240.220.176
209.240.220.177
216.239.46.17
216.239.46.27
216.239.46.34
216.239.46.168
130.239.126.113
206.190.23.112
193.130.225.253

- -- 
- ----------------------------------------------------------------------
Phil Brutsche				    pbrutsch@tux.creighton.edu

GPG fingerprint: 9BF9 D84C 37D0 4FA7 1F2D  7E5E FD94 D264 50DE 1CFC
GPG key id: 50DE1CFC
GPG public key: http://tux.creighton.edu/~pbrutsch/gpg-public-key.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6oEie/ZTSZFDeHPwRAg4UAKChgEkHgE84Q1OWsB5faZczFrFLjACdGkul
sViRgWXfFAlKa3W9V8+RAYs=
=wkJl
-----END PGP SIGNATURE-----

