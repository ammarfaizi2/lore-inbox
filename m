Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVALKeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVALKeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 05:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVALKec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 05:34:32 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:47775 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261322AbVALKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 05:34:30 -0500
Date: Wed, 12 Jan 2005 11:34:28 +0100
From: Martin Waitz <tali@admingilde.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making sys_read to operate only on pipefs
Message-ID: <20050112103428.GJ3069@admingilde.org>
Mail-Followup-To: selvakumar nagendran <kernelselva@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050112064059.72521.qmail@web60608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <20050112064059.72521.qmail@web60608.mail.yahoo.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Jan 11, 2005 at 10:40:58PM -0800, selvakumar nagendran wrote:
>    I am intercepting syscalls in kernel 2.4.28. I want
> to intercept read system call for the pipefilesystem.

why not simply add your code to pipe_read in fs/pipe.c?

--=20
Martin Waitz

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB5P00j/Eaxd/oD7IRAlR8AJ44/XH8eiwEVlbSj7Gfje67LJS/wQCgg9WS
kT888QOwPNHhA8f7tgekJNM=
=pJg3
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
