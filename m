Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130140AbQLCMLM>; Sun, 3 Dec 2000 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbQLCMLC>; Sun, 3 Dec 2000 07:11:02 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:14976 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S130140AbQLCMKz>; Sun, 3 Dec 2000 07:10:55 -0500
From: Tobias Hunger <tobias@berlin-consortium.org>
To: linux-kernel@vger.kernel.org
Subject: Bugs in test8 and test11
Date: Sun, 3 Dec 2000 12:40:13 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00120312401300.00493@c3po>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello!

I encountered some wiered bugs in test8 -- and after an upgrade to test11 
there too -- yesterday. I hope this address is not totally inadequate for 
this report.

test8:

I noticed for a while now, that the keyboard on my console does not work 
sometimes. Yesterday I figured out, that this only happens when I have my 
Printer turned on. I have A Gigabyte 6BXDS Mainboard an a HP 6P Laserprinter. 
The rest of my system is quite recent (I do regular updates to whatever is in 
debian's unstable branch, the last update for this computer was about 4 weeks 
ago).

test11:

Doesen't start, but hangs right after "Uncompressing the kernel".

I since I overwrote the test8 kernel with the new one I can't produce more 
informations (I had to reinstall the kernel from my newest LInux CDs which 
unfortunatly did not allow access to my disc. I used the new e2fs-features 
that are incompatible to pre-2.2 kernels:( ). Well, it does not really matter 
because of the data, but it is bad that I can't add the informations you 
requested to this mail.

Please feel free to contact me for more information (or additional tests). 
I'll do what I can to help.

- -- 
Gruss,
Tobias

- -------------------------------------------------------------------
Tobias Hunger                  The box said: 'Windows 95 or better'
tobias@berlin-consortium.org                  So I installed Linux.
- -------------------------------------------------------------------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE6KjEiVND+cGpk748RAoMHAJ9jpQfyrryGu83fXuiVQr8QVhonggCeIT4N
OVPHDsZ6h2QAmoCe2jQhMEg=
=rrWu
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
