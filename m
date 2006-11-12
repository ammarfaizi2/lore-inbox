Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752807AbWKLTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbWKLTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbWKLTTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:19:16 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:22505 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1752807AbWKLTTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:19:15 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Date: Sun, 12 Nov 2006 20:18:51 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
References: <200611111129.kABBTWgp014081@fire-2.osdl.org> <20061112125357.GH25057@stusta.de> <1163337376.3293.120.camel@laptopd505.fenrus.org>
In-Reply-To: <1163337376.3293.120.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13544006.s0FrCKJM9O";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611122019.09851.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13544006.s0FrCKJM9O
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

On Sunday, 12. November 2006 14:16, Arjan van de Ven wrote:
> If this isn't UP this could be the first real case of "noapic" in your
> entire list...... which isn't too useful.=20
> Maybe we need to get more/any people who see "need noapic on SMP" to
> file a bug (and provide a reasonable amount of info)

I need noapic since ever (5 years!) to get my USB controller running.
Without noapic it doesn't get any interrupts for some reason.

If now is the time to fix those bugs, I would be happy to try a new kernel
and get you the dmesg + result of plugging in an usb mass storage device
and reading from it on a DAILY basis.

If you need anything else to resolve the issue, I would be happy to help=20
out here.

Maybe a pattern can be detected, which could help others.
If you like to blacklist this machine by DMI, that would also
help me.

Many Thanks!

Best Regards

Ingo Oeser

--nextPart13544006.s0FrCKJM9O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFV3OtU56oYWuOrkARAi2zAKCbeMtyw5pPNFADJG9FkncXH00gowCfXvxV
yF6tumjeg6Q77yN29Bgk8GQ=
=5jfe
-----END PGP SIGNATURE-----

--nextPart13544006.s0FrCKJM9O--
