Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTJOQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbTJOQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:56:18 -0400
Received: from tog-wakko4.prognet.com ([207.188.29.244]:48513 "EHLO virago")
	by vger.kernel.org with ESMTP id S263640AbTJOQ4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:56:14 -0400
Date: Wed, 15 Oct 2003 09:55:44 -0700
From: Tom Marshall <tmarshall@real.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
Message-ID: <20031015165544.GB2167@real.com>
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com> <3F8D63AA.9000509@mvista.com> <20031015165016.GA2167@real.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20031015165016.GA2167@real.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [*] If this is the 8254 timer, using 1192 as a divisor should result in a
> resolution of ~1,000,686 nanoseconds.

Sorry, I meant to say 1194 as a divisor.

--=20
Meekness:  Uncommon patience in planning a revenge that is worth while.
        -- Ambrose Bierce

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jXwQqznSmcYu2m8RAlCzAJ9Qw5N4i8GFeU2egoDhgyXOP/DxpwCbB5jQ
nvtYBuU4nmMHTLkWREfuIgE=
=oTKQ
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
