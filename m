Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWB1W0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWB1W0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWB1W0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:26:30 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:55703 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932607AbWB1W03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:26:29 -0500
Message-ID: <4404CE39.6000109@liberouter.org>
Date: Tue, 28 Feb 2006 23:27:05 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org> <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
In-Reply-To: <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Juhl napsal(a):
> Since I'm in X when the lockup happens and I don't have enough time
> from clicking the eclipse icon to the box locks up to make a switch to
> a text console I don't know if an Oops or similar is dumped to the
> console (there's nothing in the locks after a reboot)  :-(
So why don't just run eclipse from console (DISPLAY=... eclipse), or use atd,
crond... (less common variants)?

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEBM45MsxVwznUen4RAiABAKCUFCSNKZY44nCs70siadm7DKwIgACfQi8z
QQaYcwZXIsjIvVpWJAfPFog=
=thwP
-----END PGP SIGNATURE-----
