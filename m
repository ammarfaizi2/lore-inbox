Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbUKDTqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUKDTqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUKDTkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:40:36 -0500
Received: from dialin-212-144-165-120.arcor-ip.net ([212.144.165.120]:64707
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262385AbUKDT2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:28:20 -0500
In-Reply-To: <JwLGVeAP.1099582223.3370560.khali@gcu.info>
References: <JwLGVeAP.1099582223.3370560.khali@gcu.info>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-51-1030204309"
Message-Id: <A873DF0A-2E97-11D9-BF00-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: "LKML" <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: dmi_scan on x86_64
Date: Thu, 4 Nov 2004 20:28:08 +0100
To: "Jean Delvare" <khali@linux-fr.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-51-1030204309
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.11.2004, at 16:30, Jean Delvare wrote:

> According to the SMBus 2.0 specs [1], page 59, address 0x08 represents
> the SMBus host itself, so it's not a client. This SMBus is empty.
>
>> Anything else I can try?
>
> No, this bus is simply empty, no need to look any further. For some
> reason these AMD chipsets have two different SMBus. Most motherboard
> manufacturers only use the first one.

Thanks for your detective work.

Servus,
       Daniel

--Apple-Mail-51-1030204309
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYqCyDBkNMiD99JrAQLQdwgAi5B5iBtlfqxIOr7UdNm0d5QgjTRg+tMh
AVEWry3JkoqqN8axZ++NSrqqjdcLk5QY5t6AmZ5g/Lpgwnc2sM86Oaf/S0knVLAW
sKAyvACyFNaUn6uf4Df4ROWFp6wOh/Vp5abgyfL5YEtaPFmhGf1hOlXbkfq79N8W
5Rd4VQFahs5SntnQY2Zztq0VCi+zY5MGMspTLEyNBn+W1NJe8FY9gfY8Zp6YeJCE
1bDWIthkAyVLrTPf/dOsynPZPbkD7cGRgSkR0QOgKehojL85sHrOqwyOeXVdAIkt
2i4BbA2tH3VHoy1b5GcYKAVz4CelmaMzr+kr4OqKxGmHxIMNnPZNEQ==
=Qs1g
-----END PGP SIGNATURE-----

--Apple-Mail-51-1030204309--

