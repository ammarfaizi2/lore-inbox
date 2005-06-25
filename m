Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263385AbVFYJwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbVFYJwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbVFYJwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:52:10 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:19721 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263385AbVFYJv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type;
        b=GAIjS/dr4KdjIHDg1JY2GjmrENiUJBhbY0noOoMuCEWzlDPq5FGwYnbyWYn2gw2EwiPY2M33tKCkPtf3Vj/I6AAG/amIMZfhkgjnc9RVd701zwzgQE/PD8fcEM7sor0SbSy2yb0zKmzO4pVzIpcpkMuRWBEEDaEj/jopfKYigoE=
Message-ID: <42BD293E.5080803@gmail.com>
Date: Sat, 25 Jun 2005 15:21:58 +0530
From: Toufeeq Hussain <toufeeqh@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Hackers Guide to git (v3)
References: <42BCE80A.2010802@pobox.com>
In-Reply-To: <42BCE80A.2010802@pobox.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=218783B9
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD23C04ADB4D6E83C3FEEFA78"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD23C04ADB4D6E83C3FEEFA78
Content-Type: multipart/mixed;
 boundary="------------000906080409090801090508"

This is a multi-part message in MIME format.
--------------000906080409090801090508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> 2) download a linux kernel tree for the very first time
> 
> $ git clone \
>    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
>    linux-2.6

Git "clone" command not found error with git-20050622.

-toufeeq

--------------000906080409090801090508
Content-Type: text/x-vcard; charset=utf-8;
 name="toufeeqh.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="toufeeqh.vcf"

begin:vcard
fn:Toufeeq Hussain
n:Hussain;Toufeeq
email;internet:toufeeqh@gmail.com
tel;home:091-044-24832063
tel;cell:091-9840196690
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------000906080409090801090508--

--------------enigD23C04ADB4D6E83C3FEEFA78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCvSk//4Tq3iGHg7kRAgYJAJ4u+m2JqsqshFfUc6tzYSvyYV46IgCeI5Q6
riJczzvJe+oZ/p3lqmF4PKM=
=XRPX
-----END PGP SIGNATURE-----

--------------enigD23C04ADB4D6E83C3FEEFA78--
