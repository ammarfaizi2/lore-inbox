Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSAPRa4>; Wed, 16 Jan 2002 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSAPRav>; Wed, 16 Jan 2002 12:30:51 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:60199 "EHLO
	tsmtp8.mail.isp") by vger.kernel.org with ESMTP id <S285022AbSAPRaR>;
	Wed, 16 Jan 2002 12:30:17 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Antoni Bella <bella5@teleline.es>
Organization: P&S - Lliure
To: <linux-kernel@vger.kernel.org>
Subject: Bug (text) in Configure.help 2.69
Date: Wed, 16 Jan 2002 16:15:25 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020116173044Z285022-13996+7064@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


  Hello, I'm reported this bad link.

- --- Configure.help	Fri Jan 11 02:05:17 2002
+++ Configure.help.ac	Wed Jan 16 16:05:26 2002
@@ -21613,9 +21613,9 @@
   If you have one of these cameras, say Y here
   otherwise say N.
   This driver is also available as a module (w9966.o).

- -  Check out <file:drivers/media/video4linux/w9966.txt> and
+  Check out <file:Documentation/video4linux/w9966.txt> and
   <file:drivers/media/video/w9966.c> for more information.
 
 CPiA Video For Linux
 CONFIG_VIDEO_CPIA

- -- 
   Sort

######## Antoni Bella Perez ####################                             |
# http://www.terra.es/personal7/bella5/home.htm
## <bella5@teleline.es> ## i
col·laborador del projecte Debian en català: debian.org/index.ca.htm
Maquinari: - Pentium II 300MHz 128MB memòria 599.65 bogomips
Sistema:   - Debian GNU/Linux-2.4.18-pre3  -  XFree86 4.1.0-13

- -
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8RZkNGfXdVUGHvegRAt5CAKCZ37XoAXBXxtwJ4kJTCPG4ubzf5gCbBj6a
+blznJdhMJGmC8YwANcOVhc=
=PgkZ
-----END PGP SIGNATURE-----
