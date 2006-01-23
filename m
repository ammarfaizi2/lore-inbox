Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWAWL5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWAWL5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWAWL5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:57:34 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:170 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751424AbWAWL5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:57:33 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Subject: Re: [PATCH] 2.6.15: access permission filesystem 0.17
Date: Mon, 23 Jan 2006 12:57:17 +0100
User-Agent: KMail/1.9.1
References: <87ek3a8qpy.fsf@goat.bogus.local>
In-Reply-To: <87ek3a8qpy.fsf@goat.bogus.local>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1639992.A0KNYaN72i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601231257.28796@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1639992.A0KNYaN72i
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Olaf Dietsche wrote:
>This patch adds a new permission managing file system. Furthermore,
>it adds two modules, which make use of this file system.
>
>One module allows granting capabilities based on user-/groupid. The
>second module allows to grant access to lower numbered ports based on
>user-/groupid, too.

Any chance you will push this to Andrew and Linus in near future so we'll s=
ee=20
it in mainline?

Eike

--nextPart1639992.A0KNYaN72i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBD1MSoXKSJPmm5/E4RAtRrAJ9+YF+xcgIU6sSHabAaqaz6IHFUvgCeO8iP
8QJhlnUCyYPPzKSZMbgaWHY=
=LhbJ
-----END PGP SIGNATURE-----

--nextPart1639992.A0KNYaN72i--
