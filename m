Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGTNzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGTNzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVGTNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:55:35 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:48579 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261233AbVGTNyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:54:54 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Comtrol mail address from MAINTAINERS
Date: Wed, 20 Jul 2005 15:59:05 +0200
User-Agent: KMail/1.8.1
References: <200507200932.35003@bilbo.math.uni-mannheim.de> <42DE3FC0.8070500@gmail.com>
In-Reply-To: <42DE3FC0.8070500@gmail.com>
Cc: Jiri Slaby <lnx4us@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart59049569.Gf4ICVYQLy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507201559.12180@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart59049569.Gf4ICVYQLy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 20. Juli 2005 14:12 schrieb Jiri Slaby:
>Rolf Eike Beer napsal(a):
>>Every Mail to this address produces a mail telling that they do no longer
>>monitor this address and you should use their webinterface.
>>
>>"We are pleased to offer this powerful replacement to standard email
>> support."
>>
>>Some people just don't understand.
>>
>>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>>
>>--- linux-2.6.13-rc3/MAINTAINERS	2005-07-20 09:05:30.000000000 +0200
>>+++ linux-2.6.13-rc3-eike/MAINTAINERS	2005-07-20 09:13:40.000000000 +0200
>>@@ -1934,7 +1934,6 @@
>>
>> ROCKETPORT DRIVER
>> P:	Comtrol Corp.
>>-M:	support@comtrol.com
>> W:	http://www.comtrol.com
>> S:	Maintained
>
>And you can remove these:
>
>... while talking to advansys.com <http://advansys.com>.:
> >>> DATA
>
><<< 550 5.7.1 <linux@advansys.com <mailto:linux@advansys.com>>...
>Relaying denied. Proper authentication required.

Looks like the admin of their mail setup should ask someone who knows what =
he=20
does.

>550 5.1.1 <linux@advansys.com <mailto:linux@advansys.com>>... User unknown
><<< 503 5.0.0 Need RCPT (recipient)

This is just if your mailer uses PIPELINING and sent a DATA before getting =
the=20
reply to RCPT TO:

>... while talking to ali.ali.com.tw <http://ali.ali.com.tw>.:
> >>> RCPT To:<cjtsai@ali.com.tw <mailto:cjtsai@ali.com.tw>>
>
><<< 550 unknown user.
>550 5.1.1 <cjtsai@ali.com.tw <mailto:cjtsai@ali.com.tw>>... User unknown

Send a patch, you know the addresses.

Eike

--nextPart59049569.Gf4ICVYQLy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC3liwXKSJPmm5/E4RAiv0AJ9zjsTyzpFxD8Hdw4slCNGN9INKcACeOfbD
RIXjsCJt+JiBA8S/afD2X6w=
=YOYP
-----END PGP SIGNATURE-----

--nextPart59049569.Gf4ICVYQLy--
