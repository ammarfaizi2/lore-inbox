Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271836AbTGRPGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTGRPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:04:40 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:51334 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S271805AbTGROcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:32:07 -0400
Date: Fri, 18 Jul 2003 07:47:00 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6.1int
Message-ID: <20030718144700.GC12466@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org> <20030718070749.GA12466@lorien.emufarm.org> <200307181443.h6IEhnq3002916@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <200307181443.h6IEhnq3002916@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Valdis.Kletnieks@vt.edu wrote:

> This could be a result of fvwm grabbing the X server while the
> wireframe stuff is going on, and xmms being blocked trying to update
> the image on screen (think "scrolling song title" ;)

Yah, I'm pretty sure that's what it is.  I just tried it again, and I
couldn't get it to happen again, but, like I'd expect, none of the
graphics (anywhere on the screen) updated with the wireframe up.  I'd
guess xmms has some incorrect synchronization between its audio and
display threads, and I just happened to be hitting that consistently
last night, but not now.

Danek

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/GAhjG8Qe9mysFa4RAqDkAJ9mzB1j04oTRk5rR9sOZIC3PoizxQCfQnjj
BWPtnORQP8KfAbLj45XWxYs=
=xUKl
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
