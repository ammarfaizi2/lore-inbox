Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTE2RrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTE2RrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:47:21 -0400
Received: from mail.somanetworks.com ([216.126.67.42]:9601 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S262434AbTE2RrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:47:20 -0400
Date: Thu, 29 May 2003 14:00:25 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-Id: <20030529140025.61f991d4.georgn@somanetworks.com>
In-Reply-To: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.11claws175 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.vkO?b5na/qDsRL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.vkO?b5na/qDsRL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2003 21:55:39 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's
> fix for the IO stalls/deadlocks.

While others may be dubious about the efficacy of this patch, I've been
running -rc6 on my laptop now since sometime last night and have seen
nothing odd.

In case anybody cares, I'm using both ide and a ieee1394 (for a large
external drive [which implies scsi]) and I do a _lot_ of big work with
BK so I was seeing the problem within hours previously.

-g

--=.vkO?b5na/qDsRL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+1kq8oJNnikTddkMRAic2AKCOGesfqauU/F+jhPJLpVIVLc1HzgCgvDLo
bHhD94bmxmEZCEdNQRp7PzQ=
=ujaU
-----END PGP SIGNATURE-----

--=.vkO?b5na/qDsRL--
