Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUG2PlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUG2PlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUG2Phk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:37:40 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:13515 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S268140AbUG2PQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:16:57 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
Date: Thu, 29 Jul 2004 16:20:10 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407281050.24958.m.watts@eris.qinetiq.com> <200407291606.58636.m.watts@eris.qinetiq.com> <ufa8yd2vodw.fsf@epithumia.math.uh.edu>
In-Reply-To: <ufa8yd2vodw.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407291620.10226.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.51; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> >>>>> "MW" == Mark Watts <m.watts@eris.qinetiq.com> writes:
>
> MW> Out of interest Jason, do you have the 3Ware plugged into a 64bit
> MW> or 32bit pci slot?
>
> This board has only 64-bit slots; the card is actually in a 133MHz
> PCI-X slot, but of course it only runs at 66MHz.
>
>  - J<

Ok - it seems it doesn't matter what kind of slot its in then - mine is in a 
32bit/33MHz slot.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCRWqBn4EFUVUIO0RAlO+AJ4iHMkqQclb5uLziLRhnd2l+W+N6wCeI2kn
1p7ZB3z/g/8xXUprOzu575o=
=cwho
-----END PGP SIGNATURE-----
