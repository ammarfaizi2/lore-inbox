Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVAYUWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVAYUWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVAYUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:22:52 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:37371 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262092AbVAYUWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:22:50 -0500
Date: Tue, 25 Jan 2005 15:22:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: wait_for_completion API extension addition
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41F6AA83.20306@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ingo,

I noticed that the wait_for_completion API extensions made it into mainline.

However, I posted that the patch in question is broken a while back:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110131832828126&w=2

Can we fix this?

Thanks,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9qqDdQs4kOxk3/MRAnKmAJ4oAfPDj7fQrljahvQKWsOMGq7F2wCcDyMI
oLJAXgNbAyhJEC0DFfozn0M=
=dbKU
-----END PGP SIGNATURE-----
