Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVJULkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVJULkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 07:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVJULkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 07:40:40 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:2532 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S964908AbVJULkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 07:40:39 -0400
Date: Fri, 21 Oct 2005 13:40:37 +0200
From: Lasse Bigum <zenith@cs.aau.dk>
To: linux-kernel@vger.kernel.org
Subject: System limits on System V IPC methods
Message-ID: <20051021114037.GC26262@meridian.cs.aau.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

First off, a short introduction to us and the work we intend to do.
We are a group of students. As part of our project this semester, we are
investigating ways of implementing secure IPC for Linux.

We have found that a way of limiting the number of shared memory
segments that a process can allocate can be specified by adjusting
SHMSEG. This is part of the System V IPC specs.
However, it seems that this is not implemented in Linux, but there are
traces of it to be found around in the kernel.

Are there any specific reasons that this is not implemented yet, or is
it just a matter of getting someone to volunteer to do so? If the latter
is the case, we would like to give it a shot.

Regards,
Lasse Bigum

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDWNO1mgIf0VjuOJkRAsQNAJ9LTFeju3DeYiZOfCyYF7EF9OLShgCgr8lH
t9fPLqFD+5RCWSIxxcEwtVA=
=DYfd
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
