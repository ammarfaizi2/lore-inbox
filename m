Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267643AbUG3G1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267643AbUG3G1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267663AbUG3G1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:27:51 -0400
Received: from pop.gmx.de ([213.165.64.20]:45245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267665AbUG3G0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:26:03 -0400
X-Authenticated: #4512188
Message-ID: <4109E9F8.9080600@gmx.de>
Date: Fri, 30 Jul 2004 08:26:00 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040710)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Love <rml@ximian.com>, "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
References: <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com> <20040728145543.GB18846@devserv.devel.redhat.com> <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com> <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost> <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost> <20040730061005.GF18347@suse.de>
In-Reply-To: <20040730061005.GF18347@suse.de>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jens Axboe wrote:
| On Fri, Jul 30 2004, Robert Love wrote:
|
|>On Fri, 2004-07-30 at 07:53 +0200, Jens Axboe wrote:
|>
|>
|>>read-ahead doesn't matter on ripping audio, just for fs work.
|>
|>This isn't ripping, just playing.
|
|
| Strange, something else must be accessing the drive at the same time.
|
| So the question is - what else is accessing the drive?

Could it be famd?

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBCen4xU2n/+9+t5gRAks0AKDxR4217lUGmNNDznYZU6VOWdE1IQCeKNou
2njaepIb6XS11k/7Imj8zto=
=KRNO
-----END PGP SIGNATURE-----
