Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUHaJDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUHaJDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHaJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:03:08 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:23188 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267526AbUHaJDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:03:00 -0400
Date: Tue, 31 Aug 2004 11:01:58 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Bill Huey <bhuey@lnxw.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with reiser4)
Message-ID: <20040831090158.GC14371@thundrix.ch>
References: <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com> <20040831053055.GA8654@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20040831053055.GA8654@nietzsche.lynx.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Aug 30, 2004 at 10:30:55PM -0700, Bill Huey wrote:
> DragonFly BSD, the only remotely functional open source BSD project on this
> planet, has plans in place to push certain kernel components like their VFS
> layer into userspace for easier debugging, testing and other things that go
> with developing file systems easily. If they back it with something like C++
> for doing constructor style type conversion on top of overloaded operators
> to back VFS data structure translation, could easily import stuff like most
> Linux file systems without major restructuring, say, if they had their
> translation library written. In this case, userspace kernel systems have
> some serious programming advantages over traditional kernels.

Uh, what about enhancing lufs code in this regard and porting all fs'es to it?

				Tonnerre

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBND6G/4bL7ovhw40RAki+AKCskVJSbMAAPqFmCWbIY+cItCJJVQCeI1Di
qOThG2G68wYEQCBndoPXNx0=
=bnoc
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
