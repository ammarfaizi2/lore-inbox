Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268977AbUHaTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268977AbUHaTPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUHaTMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:12:54 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:32917 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268860AbUHaTLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:11:13 -0400
Date: Tue, 31 Aug 2004 21:08:14 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: V13 <v13@priest.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Message-ID: <20040831190814.GA15493@thundrix.ch>
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com> <36793180.20040831201736@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <36793180.20040831201736@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Tue, Aug 31, 2004 at 08:17:36PM +0200, Spam wrote:
>   How  are  things  done on Windows platforms when there are files and
>   directories  with the same name? In Unix that is imposible. How does
>   it  work  for  environments  like  Cygwin  etc? What happen to tools
>   that run in them?

In  NTFS it's  illegal  IIRC.  At least  the  fs correction  utilities
complain about a block being assigned to two files.

Same with HFS+.

Sometimes  there seem to  be several  things with  the same  name. But
that's because of hidden extensions (.lnk for example).

I'm talking out of the book here, maybe the real-world implementations
of Windows  are different. I can't  tell, I only used  Windows once to
ssh into a screwed-up router.

				Tonnerre


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBNMyd/4bL7ovhw40RAiIcAJ9p8jLgJeKhIFuWqVmJ/ShSiz6L+ACgwTVN
N/3DwpJuNBNtx2Sjb9xdZ8A=
=ER/w
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
