Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVB1Qvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVB1Qvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVB1QuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:50:25 -0500
Received: from [63.227.221.253] ([63.227.221.253]:46825 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S261683AbVB1QsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:48:05 -0500
X-Mailer: exmh version 2.3.1 11/28/2001 with nmh-1.1
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>,
       dri-devel@lists.sourceforge.net, Keith Packard <keithp@keithp.com>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..) 
From: Keith Packard <keithp@keithp.com>
In-Reply-To: Your message of "Mon, 28 Feb 2005 11:06:12 EST."
             <Pine.LNX.4.62.0502281051350.28870@node2.an-vo.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1169233748P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Feb 2005 08:47:41 -0800
Message-Id: <E1D5o3Z-0001Zo-As@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1169233748P
Content-Type: text/plain; charset=utf-8


Around 11 o'clock on Feb 28, Vladimir Dergachev wrote:

> I agree. For example, on my Dell notebook the graphics card is not 
> reinitialized properly on return from resume. At some point I'll get 
> bothered enough to write code that does it.

# vbetool post

Run from your suspend script while on a text VT.

-keith



--==_Exmh_1169233748P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.3.1 11/28/2001

iD8DBQFCI0stQp8BWwlsTdMRAnDNAKDbkbohNn6ndTbNkGXiVagWcNwkFQCfS8AM
PmjEW3CZysjq4bxIPwib4LU=
=zwE0
-----END PGP SIGNATURE-----

--==_Exmh_1169233748P--
