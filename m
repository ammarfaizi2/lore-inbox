Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJNQ4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJNQ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:56:34 -0400
Received: from ns.exp-math.uni-essen.de ([132.252.150.1]:10121 "EHLO
	pilz.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id S262609AbTJNQ4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:56:32 -0400
From: Andreas Jungmaier <ajung@exp-math.uni-essen.de>
Organization: University Duisburg-Essen
To: linux-kernel@vger.kernel.org
Subject: Compile warning for smbfs
Date: Tue, 14 Oct 2003 18:59:13 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310141859.24529.ajung@exp-math.uni-essen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I am compiling linux-2.4.6-test7 and got the following warning:

CC [M]  fs/smbfs/inode.o
  fs/smbfs/inode.c: In function `smb_fill_super':
  fs/smbfs/inode.c:554: warning: comparison is always false due to limited range of data type
  fs/smbfs/inode.c:555: warning: comparison is always false due to limited range of data type
CC [M]  fs/smbfs/file.o

*Maybe* that needs to be fixed. Just to let you know.
Please CC any answers also to my email address.

Apart from that, this kernel runs great on my Toshiba Tecra 8200.

Best regards,
Andreas 
- -- 
Dipl.-Ing. Andreas Jungmaier              
Computer Networking Technology Group     
University of Duisburg-Essen                       
http://www.exp-math.uni-essen.de/~ajung   
PGP Key-ID: D382 4AC0             

PGP Key-Fingerprint: 228C 7C2C 3381 2DD4  9998 2812 5C0B 0B04  D382 4AC0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/jCtmXAsLBNOCSsARAoCcAKCv/fRePMZ94llFv67qxhnmY6mHmACcDtxo
UXBr0jcXuBKjwk3rCVixCpk=
=stDT
-----END PGP SIGNATURE-----

