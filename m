Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWDKWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWDKWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDKWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:24:27 -0400
Received: from mx0.karneval.cz ([81.27.192.107]:54929 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1751164AbWDKWY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:24:27 -0400
Message-ID: <443C2CA7.6000800@gmail.com>
Date: Wed, 12 Apr 2006 00:24:39 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bernard Pidoux <pidoux@ccr.jussieu.fr>
CC: linux-kernel@vger.kernel.org, Bernard Pidoux <bpidoux@free.fr>
Subject: Re: [kernel 2.6] Patch for mxser.c driver
References: <443C1DA0.1030004@ccr.jussieu.fr>
In-Reply-To: <443C1DA0.1030004@ccr.jussieu.fr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernard Pidoux napsal(a):
> Hi,
> 
> mxser driver in kernel 2.6.16 can compile but it does not drive the
> serial multiport adapter from Moxa.
> 
> According to Moxa documentation for version 1.8, msmknod script,
> downloaded from their support site, creates ttyM0-7 and cum0-7 tty
> devices with major numbers 30 and 35 by defaults.
Anyway, it should be /proc/devices dependent.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEPCynMsxVwznUen4RAgUVAKDCCrpJ+Gc6C08k1PmwB/k1aELs/ACfUIA9
RxAwuNyDP0mrPLbx2bn9OFk=
=VGac
-----END PGP SIGNATURE-----
