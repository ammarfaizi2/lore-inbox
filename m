Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752403AbWCFTFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbWCFTFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbWCFTFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:05:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:34704 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750774AbWCFTFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:05:54 -0500
Subject: Re: [PATCH] leave APIC code inactive by default on i386
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Ellerman <michael@ellerman.id.au>,
       linux-kernel@vger.kernel.org, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20060306181716.GC15971@redhat.com>
References: <43D03AF0.3040703@us.ibm.com>
	 <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
	 <20060301043353.GJ28434@redhat.com> <20060306125018.GA1673@elf.ucw.cz>
	 <20060306171747.GN21445@redhat.com> <20060306174122.GA2716@elf.ucw.cz>
	 <20060306175238.GA15971@redhat.com> <20060306175811.GB2716@elf.ucw.cz>
	 <20060306181716.GC15971@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9ZJoVgY5BMWbqlWKRcha"
Date: Mon, 06 Mar 2006 11:05:48 -0800
Message-Id: <1141671948.30185.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ZJoVgY5BMWbqlWKRcha
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-06 at 13:17 -0500, Dave Jones wrote:

> I (and Darrick) already agreed further up in this thread that it wasn't n=
eeded.
> I think we're actually in agreement ;)

Yep.  Maybe it's time I cough up a patch that does this. :)

--D

--=-9ZJoVgY5BMWbqlWKRcha
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEDIgMa6vRYYgWQuURAorNAJ9tYnfP/nG/dAwSMrhBL2j/WdZkfACfQyDD
QBOAQVsrWlphhj9fqfPXedw=
=/06a
-----END PGP SIGNATURE-----

--=-9ZJoVgY5BMWbqlWKRcha--

