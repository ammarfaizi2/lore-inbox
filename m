Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTJKOaj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTJKOaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:30:39 -0400
Received: from h80ad24a2.async.vt.edu ([128.173.36.162]:60808 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262109AbTJKOah (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:30:37 -0400
Message-Id: <200310111430.h9BEUX6s019836@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: asdfd esadd <retu834@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model 
In-Reply-To: Your message of "Fri, 10 Oct 2003 21:45:14 PDT."
             <20031011044514.19799.qmail@web13005.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031011044514.19799.qmail@web13005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-414290864P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Oct 2003 10:30:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-414290864P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Oct 2003 21:45:14 PDT, asdfd esadd said:

> * a unified well architected core component model
> which is extensible

OK.. now for the terminally dense readers of the list like myself, could
you repeat that in terms that people who have more experience in
slinging C code than buzzwords will understand and rally behind?

Most of the time when I hear "component", somebody's trying to invent
yet another message-passing paradigm.  And although there's certainly
a place where things like CORBA and the dbus stuff solve problems,
you have to remember that this is a Linux kernel, not Mach....

Alternatively, explain to me what this component model will do for us
that updating the docs on the kernel API won't?

--==_Exmh_-414290864P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iBQIcC3lWbTT17ARAl3xAKDOmTiLzmyMbAy+rc/PBJQ/SOLUWQCgwBro
Ph7tL+t2X/qRxQ2GvgAyBoQ=
=XERl
-----END PGP SIGNATURE-----

--==_Exmh_-414290864P--
