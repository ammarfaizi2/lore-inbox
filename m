Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRKBKWB>; Fri, 2 Nov 2001 05:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280643AbRKBKVl>; Fri, 2 Nov 2001 05:21:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:18554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280638AbRKBKVh> convert rfc822-to-8bit;
	Fri, 2 Nov 2001 05:21:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols
Date: Fri, 2 Nov 2001 12:22:37 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200111020954.fA29sf413054@riker.skynet.be>
In-Reply-To: <200111020954.fA29sf413054@riker.skynet.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102102140Z280638-17408+9329@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi
There are a more unresolved symbols in:

depmod: *** Unresolved symbols in
/lib/modules/2.4.14-pre7/kernel/drivers/block/loop.o
depmod:         unlock_page
depmod: *** Unresolved symbols in
/lib/modules/2.4.14-pre7/kernel/fs/isofs/isofs.o
depmod:         unlock_page
depmod: *** Unresolved symbols in
/lib/modules/2.4.14-pre7/kernel/fs/smbfs/smbfs.o
depmod:         unlock_page

Bye

Am Freitag, 2. November 2001 11:53 schrieb jarausch@belgacom.net:
> Hi,
>
> trying to build 2.4.14-pre7 breaks with the error message
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o depmod:
> unlock_page
>
> during make modules_install.
>
> 2.4.14-pre6 is running fine here.
>
> Thank for hint,
> Helmut Jarausch
>
> Inst. of Technology
> RWTH Aachen
> Germany
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE74oH/vIHrJes3kVIRAor2AKCUi5Uf98lvFCZwsIYaEnRS4Y7yhACcCJqG
HmAcNnrowgMPOaRyI9s1lD0=
=m5TA
-----END PGP SIGNATURE-----
