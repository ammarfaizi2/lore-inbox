Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbTFLE1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTFLE1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:27:05 -0400
Received: from ns.suse.de ([213.95.15.193]:61198 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264719AbTFLE1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:27:03 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Mika =?ISO-8859-1?Q?=20Penttil=E4?= <mika.penttila@kolumbus.fi>,
       ak@suse.de, vojtech@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] New x86_64 time code for 2.5.70
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	<3EE79FD1.8060503@kolumbus.fi>
	<1055366925.17154.95.camel@serpentine.internal.keyresearch.com>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 12 Jun 2003 06:40:46 +0200
In-Reply-To: <1055366925.17154.95.camel@serpentine.internal.keyresearch.com> (Bryan
 O'Sullivan's message of "11 Jun 2003 14:28:45 -0700")
Message-ID: <u8d6hjgb75.fsf@gromit.moeb>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Bryan O'Sullivan <bos@serpentine.com> writes:

> On Wed, 2003-06-11 at 14:32, Mika Penttil=E4 wrote:
>
>> Line below seems to be wrong, given hpet period is in fsecs.
>
> I don't believe the HPET code got much testing in 2.4, and my boxes

It got quite some testing on my boxes,

> don't have ACPI table entries for the HPET, so it's troublesome to test
> it on them.

Please tell your board vendor to fix it,
Andreas
=2D-=20
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+6AROOJpWPMJyoSYRAsAjAJ9dtwvhHLJaPVLvAJorJG9qcDoZ9ACfdFYx
2TEqPi1V3DODvzI2TQEafP4=
=rcHP
-----END PGP SIGNATURE-----
--=-=-=--
