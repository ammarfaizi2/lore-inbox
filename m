Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbTBDJXn>; Tue, 4 Feb 2003 04:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBDJXn>; Tue, 4 Feb 2003 04:23:43 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18159 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267197AbTBDJXm>; Tue, 4 Feb 2003 04:23:42 -0500
Subject: Re: 2.5.59-mm8
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030203233156.39be7770.akpm@digeo.com>
References: <20030203233156.39be7770.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cP/ofPZhVrjNA8EDpk7+"
Organization: Red Hat, Inc.
Message-Id: <1044351186.1421.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Feb 2003 10:33:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cP/ofPZhVrjNA8EDpk7+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-04 at 08:31, Andrew Morton wrote:

> . The reworked ia32 balancing patch from Nitin Kamble is stable, and is
>   consistently showing benefit for heavy networking loads on large SMP
>   machines.  Even though everyone seems to agree that a userspace solutio=
n to
>   this is smarter, that's no reason to hold back on improving the
>   kernel-based solution so I shall be submitting that patch.

<shameless plug>
A version of a proposed userspace solution can be found at
http://people.redhat.com/arjanv/irqbalance/irqbalance-0.05.tar.gz
</shameless plug>

It's still relatively simple, but it has the buildingblocks for becoming
more advanced.

Greetings,
   Arjan van de Ven

--=-cP/ofPZhVrjNA8EDpk7+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+P4jRxULwo51rQBIRApJEAJ9kNbutfBCdPltJe4D8v1YWPqmpcgCfUI/g
1pPvozNSDUGzQtmMQIK65as=
=yxqU
-----END PGP SIGNATURE-----

--=-cP/ofPZhVrjNA8EDpk7+--
