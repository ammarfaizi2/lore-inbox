Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVBYHwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVBYHwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVBYHwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:52:30 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:62567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262643AbVBYHwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:52:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=AcU6oAq8lPUCnbMzbGdX7wAnkLbWjXxSlRJAO4DfrV3pV2NfFaVCtu4R6ICI3nQXTZaLfRSuhOR5TfA+T38H0GrpwBrTMMD4Gk/Qkh4hfPMn+WJv0iNV7xMVI6/54b3XrHnUGHjSmW9A3Hq97iX/MQdBUQXKvGu9AvX51mQ7B5Q=
Message-ID: <421ED92D.4040905@gmail.com>
Date: Fri, 25 Feb 2005 09:52:13 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark McPherson <mark@mahonia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5 -- Some
References: <pan.2004.03.30.06.06.42.430786@mahonia.com>
In-Reply-To: <pan.2004.03.30.06.06.42.430786@mahonia.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA94D6291B60B29DDDEC1AC5A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA94D6291B60B29DDDEC1AC5A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Mark McPherson wrote:
> Hello all,
> 
> I have a Shuttle XPC with an nForce2 chipset.
> 
> Here's something which shows up in dmesg after booting
> 2.6.5-rc2-mm5; it does not appear in the Linux tree up through
> 2.6.5-rc2-bk9. 
> 
> My external IEEE1394 drive attaches and detaches and
> transfers data without apparent complaint.

Wait, do you mean that it works only with 2.6.5-rc2-mm5, or that it works fine 
in all kernels after 2.6.5-rc2-bk9?

These are pretty old kernels... What about newer ones?

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enigA94D6291B60B29DDDEC1AC5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCHtkwA7Qvptb0LKURAiBQAJ9t3JcFVu31sB/j2K7EbpEX2+wHjwCfaGDO
g51QVVGTOGLGdliRwsHb154=
=wJPJ
-----END PGP SIGNATURE-----

--------------enigA94D6291B60B29DDDEC1AC5A--
