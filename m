Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTEEIiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTEEIiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:38:04 -0400
Received: from [195.95.38.160] ([195.95.38.160]:58611 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262099AbTEEIiD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:38:03 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [FIXED 2.5.69] Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Mon, 5 May 2003 10:51:03 +0200
User-Agent: KMail/1.5.1
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304240940.21553.devilkin-lkml@blindguardian.org> <20030424085756.A9597@flint.arm.linux.org.uk>
In-Reply-To: <20030424085756.A9597@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051051.09629.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just reporting that this now works fine under 2.5.69. Whatever the problem, 
it's definitely gone now.

DK
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tiX5puyeqyCEh60RAvk1AJ9Qvygxk+70PFSKSSLKTgUi2mWmJwCaAjf0
5AR6Cz0LF6fC9g6Nd5t2eP8=
=o4WM
-----END PGP SIGNATURE-----

