Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTJSV1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTJSV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:27:18 -0400
Received: from mout2.freenet.de ([194.97.50.155]:36508 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262237AbTJSV1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:27:16 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Sun, 19 Oct 2003 23:27:10 +0200
User-Agent: KMail/1.5.4
References: <200310180018.21818.rob@landley.net> <200310191245.55961.mbuesch@freenet.de> <20031019210453.GE16761@alpha.home.local>
In-Reply-To: <20031019210453.GE16761@alpha.home.local>
Cc: Nick Piggin <piggin@cyberone.com.au>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org, rob@landley.net
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310192327.10756.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 19 October 2003 23:04, Willy Tarreau wrote:
> I don't know if people have already tested LZO and NRV (used in UPX).
> Perhaps LZO might already be a little better than gzip, while faster and
> with less code. NRV is surely better, but is not open source IIRC. Perhaps
> Markus would agree to release a free NRV decompressor if asked kindly ?

If NRV is closed source (I don't know), then we would need a free
compressor _and_ a free decompressor. Because I don't think we should
go and compile (compress) the kernel image with some closed-source
software. 8-)

> Regards,
> Willy

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/kwGuoxoigfggmSgRArzRAJ4rNgBumLFlQ9q+OincNpxmL2uKaQCePZi2
DFXJPIOdcY4IoAivT6gBmOg=
=uOq6
-----END PGP SIGNATURE-----

