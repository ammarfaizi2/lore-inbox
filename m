Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTAPVMd>; Thu, 16 Jan 2003 16:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTAPVMc>; Thu, 16 Jan 2003 16:12:32 -0500
Received: from mailg.telia.com ([194.22.194.26]:63682 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S267265AbTAPVMb>;
	Thu, 16 Jan 2003 16:12:31 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Date: Thu, 16 Jan 2003 22:21:19 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: restricting nfs
Message-Id: <20030116222119.236b32fc.smiler@lanil.mine.nu>
In-Reply-To: <003501c2bd98$e880d0b0$3640a8c0@boemboem>
References: <003501c2bd98$e880d0b0$3640a8c0@boemboem>
Organization: LANIL
X-Mailer: Sylpheed version 0.8.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.DKfvq,wpzvHR3("
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.DKfvq,wpzvHR3(
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2003 20:53:14 +0100
"Folkert van Heusden" <folkert@vanheusden.com> wrote:

<snip>
> I have a request :-)
> It would be nice if it would be possible to restrict the interfaces
> on which the kernel-part of nfsd is listening. Maybe not just the
> interface, but like that you can say; only accept connections from
> 192.168.64.0/24 or so.
</snip>

Maybe netfilter can solve that problem for you.
There are good docs at http://www.netfilter.org/documentation/
and in man 8 iptables.

Happy hacking :)

-- 
Christan Axelsson
smiler@lanil.mine.nu

--=.DKfvq,wpzvHR3(
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JyJVyqbmAWw8VdkRAtaaAJ4w2dZYWG2AFRcsTsY8NNV9cCryCQCeLw2a
9BVtatAXMTW8/DCHLvKnv6o=
=N9pw
-----END PGP SIGNATURE-----

--=.DKfvq,wpzvHR3(--
