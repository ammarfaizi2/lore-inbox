Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbULFGqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbULFGqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 01:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbULFGqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 01:46:14 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:58321 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261195AbULFGqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 01:46:08 -0500
Date: Mon, 6 Dec 2004 17:46:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
Message-Id: <20041206174604.036c5b08.sfr@canb.auug.org.au>
In-Reply-To: <20041206111634.44d6d29c.sfr@canb.auug.org.au>
References: <20041205004557.GA2028@us.ibm.com>
	<20041206111634.44d6d29c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Dec_2004_17_46_04_+1100_.cKCJr3vely1lWqV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Dec_2004_17_46_04_+1100_.cKCJr3vely1lWqV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 6 Dec 2004 11:16:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > Thoughts?
> 
> None, sorry :-)

Actually, Rusty suggests stop_machine() ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__6_Dec_2004_17_46_04_+1100_.cKCJr3vely1lWqV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtAAs4CJfqux9a+8RAvssAJ0e8fF8qLb7abRvrmyGl0207QDOjgCeOvL8
2FbIxOPvg8lqkf3fPNACT6o=
=0HYf
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Dec_2004_17_46_04_+1100_.cKCJr3vely1lWqV--
