Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTLIFtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLIFtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:49:05 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:11856 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263101AbTLIFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:49:03 -0500
Message-ID: <3FD56241.3070606@yahoo.es>
Date: Tue, 09 Dec 2003 00:48:49 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.0-testX show stoppers
References: <3FD498A0.9080802@yahoo.es> <1070898030.2098.146.camel@athlonxp.bradney.info>
In-Reply-To: <1070898030.2098.146.camel@athlonxp.bradney.info>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig756B0C56FCDBD44A8EB116D5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig756B0C56FCDBD44A8EB116D5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Craig Bradney wrote:
> For the Athlon, keep in touch with the nforce thread on here.. There are
> patches due to timing issues with the nforce chipset. 
> 
> For me, so far, just using this one works:
> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch
> 
> There is a program called athcool to turn off CPU Disconnect if you dont
> have that in your BIOS. I havent used this patch as I have found
> reliability using the first one I mentioned.
> 
> Craig
> 

I went ahead and used the entire -bart1 patch and life is good.  No more
lockups.  It would be great to see this go into the main tree.

-Roberto

--------------enig756B0C56FCDBD44A8EB116D5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/1WJNTfhoonTOp2oRAvLeAKDeha+or+y+vJD4L101ArXcuqEMawCfcU+X
RKftztGykvY2dHUqseOndAc=
=judY
-----END PGP SIGNATURE-----

--------------enig756B0C56FCDBD44A8EB116D5--

