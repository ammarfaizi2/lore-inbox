Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUATOoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUATOoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:44:20 -0500
Received: from ns1.cypress.com ([157.95.67.4]:41193 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id S265532AbUATOoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:44:19 -0500
Message-ID: <400D3EB4.7040909@cypress.com>
Date: Tue, 20 Jan 2004 08:44:04 -0600
From: Thomas Dodd <ted@cypress.com>
Reply-To: linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.6b) Gecko/20031216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Olaf Dabrunz <od@suse.de>
Subject: Re: ALSA vs. OSS
References: <1074532714.16759.4.camel@midux> <Pine.LNX.4.58.0401192036070.3707@pnote.perex-int.cz> <20040120142422.GA14811@suse.de>
In-Reply-To: <20040120142422.GA14811@suse.de>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Olaf Dabrunz wrote:
| On 19-Jan-04, Jaroslav Kysela wrote:
|>We don't do this in kernel. We implemented the direct stream mixing in
our
|>library (userspace). If your applications already uses ALSA APIs or if
you
|>redirect the OSS ioctls to ALSA library (our aoss library), you can enjoy
|
|   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| How can this be done? Just by creating symlinks?

Reread what was written. the aoss library does that.

	-Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (SunOS)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFADT6y+mwggWqA1pQRAnqYAJ4nj30y/yvITXvcgyq4AEMuJ87/ZwCeP4hv
lP7TW5saZHHZh5F8NJ2k/aI=
=5HeP
-----END PGP SIGNATURE-----
