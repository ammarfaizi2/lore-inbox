Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUADP75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUADP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:59:57 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:58872 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265709AbUADP74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:59:56 -0500
Date: Sun, 4 Jan 2004 15:59:40 +0000
From: Ciaran McCreesh <ciaranm@gentoo.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-Id: <20040104155940.476448f2@snowdrop.home>
In-Reply-To: <20040104144350.GD24913@louise.pinerecords.com>
References: <200401041410.i04EA61e007769@harpo.it.uu.se>
	<20040104144350.GD24913@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu"
X-OriginalArrivalTime: 04 Jan 2004 16:00:11.0290 (UTC) FILETIME=[D53077A0:01C3D2DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2004 15:43:50 +0100 Tomas Szepe <szepe@pinerecords.com>
wrote:
| +config MPENTIUMM
| +	bool "Pentium M (Banias/Centrino)"
| +	help
| +	  Select this for Intel Pentium M chips.  This option enables
| +	  compile flags optimized for the chip, uses the correct cache
| +	  shift, and applies any applicable Pentium III/IV

That should probably read "Pentium III/4".

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm


--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+Dh396zL6DUtXhERAnAeAJ9sF2hG1DDXr+wDUm3Tg4oZYEH2MQCfemTD
PrlS+9B83yCA5wVLmfTi4jU=
=X9PQ
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Jan_2004_15_59_41_+0000_.cWKGb=mK4TKqteu--
