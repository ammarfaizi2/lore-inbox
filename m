Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWFPVi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWFPVi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFPVi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:38:28 -0400
Received: from flexserv.de ([213.239.215.214]:21737 "EHLO lion.flexserv.de")
	by vger.kernel.org with ESMTP id S1751341AbWFPVi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:38:27 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
Organization: Flexserv
In-Reply-To: <200606161835.26428.s0348365@sms.ed.ac.uk> (Alistair John
 Strachan's message of "Fri, 16 Jun 2006 18:35:26 +0100")
References: <878xnx19bs.fsf@xserver.flexserv.de>
	<200606161835.26428.s0348365@sms.ed.ac.uk>
From: daniel+devel.linux.lkml@flexserv.de
X-GPG-ID: 0x7B196671
X-GPG-FP: A9CE 5788 44D3 A1A2 46B6  A727 53D8 DD4B 7B19 6671
X-message-flag: Formating hard disk. please wait...   10%...   20%...
Date: Fri, 16 Jun 2006 23:38:05 +0200
Message-ID: <87irn0zsqq.fsf@xserver.flexserv.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> On Friday 16 June 2006 15:09, daniel+devel.linux.lkml@flexserv.de wrote:
>> What additional informatiuon can i get you?

On a tmpfs or ext2/3  i dont get it.

> Just make sure you've run memtest for at least a couple passes to elimina=
te=20
> bad RAM. This could still easily be an XFS bug, but it's worth checking.
Its an full equiped E420R 4*450Mhz 4GB RAM.
I dont know  a memtesttool for sparcs.
If you know one please drop me a line.
every test from obp runs fine.

Daniel

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkyTEU9jdS3sZZnERAj0tAJ0UWZTcFQEDILjauIR3MVmBnTxccwCgkMzl
uH2dTrfSPBjOpF5VONcGxV0=
=n9Yz
-----END PGP SIGNATURE-----
--=-=-=--

