Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbSJFKjH>; Sun, 6 Oct 2002 06:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbSJFKjH>; Sun, 6 Oct 2002 06:39:07 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:15888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263374AbSJFKjG>;
	Sun, 6 Oct 2002 06:39:06 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Benjamin Walkenhorst <krylon@gmx.net>
To: mec@shout.net
Subject: Error configuring linux-2.5.40
Date: Sun, 6 Oct 2002 12:43:26 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20021006103906Z263374-8740+7447@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I recently downloaded the most recent version of the developer's branch of 
the linux kernel tree (2.5.40). Trying to configure it, I encountered an 
error:
In case this matters, the 2.5.40-source-tree was downloaded as .tar.bz2 from 
the german mirror of kernel.org (ftp.de.kernel.org) and extracted to 
/usr/local/src/linux-2.5.40 with a symlink at /usr/src/linux
I tried to configure the source tree as root.
Now for the error I got:

- -------------------------------------------------------------------------------------
Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
- -------------------------------------------------------------------------------------

As the error tells me to report to you, I hereby do so. 

Have a nice day,

Benjamin Walkenhorst
- -- 
- -------------------------------------
Der Hoffnung beraubt sein,         
heiﬂt noch nicht - Verzweifeln.    
(Albert Camus)                          
- -------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Public Key available at http://www.krylon.de

iD8DBQE9oBPVoYumWdMvhMQRAolCAJ9/XnCLf6lUNmQ6JZoG+7iGNtdUjwCfdkh/
sMiZS9R6gX4vXYgCl5cwzpU=
=1Fe8
-----END PGP SIGNATURE-----
