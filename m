Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUEHK3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUEHK3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUEHK3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:29:51 -0400
Received: from mout0.freenet.de ([194.97.50.131]:3534 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S263868AbUEHK3k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:29:40 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Axel =?utf-8?q?Wei=C3=9F?= <aweiss@informatik.hu-berlin.de>
Subject: Re: module-licences / tainting the kernel
Date: Sat, 8 May 2004 12:29:06 +0200
User-Agent: KMail/1.6.2
References: <200405080957.57286.aweiss@informatik.hu-berlin.de> <1084003417.3843.9.camel@laptop.fenrus.com> <200405081224.49890.aweiss@informatik.hu-berlin.de>
In-Reply-To: <200405081224.49890.aweiss@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405081229.15539.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 08 May 2004 12:24, you wrote:
> What does this actually mean (I'm no lawyer and somehow confused about it)? As 
> I understand, GPL sais: 'every piece of code that relies on me, must be 
> GPL'ed and therefore be available as source code', while LGPL sais: 'you may 
> develop proprietary software that relies on me, but if you change me, your 
> changes must be available as source code'.
> 
> I want to permit proprietary extensions *in user-space* for my 
> open-source-project, that contains some device-drivers for DSP-cards, and 
> partly relies on them. Does your second statement mean that as long as 
> there's only source-code, it may be LGPL (and extendable), but if you *use* 
> it (e.g. load the kernel-modules), everything that relies on the modules must 
> be GPL?

You may have a look at Linus' comment in the
COPYING file of the kernel tree.

> 			Axel

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAnLZ6FGK1OIvVOP4RAjvDAKCiFVDEHWOMtR5i/DwTt8iguA2+BwCfWiOa
B1shQRhLGvSWv1/fgNfQOGo=
=6og7
-----END PGP SIGNATURE-----
