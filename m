Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbRE0BLO>; Sat, 26 May 2001 21:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbRE0BLE>; Sat, 26 May 2001 21:11:04 -0400
Received: from srvr1.telecom.lt ([212.59.0.10]:30214 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S262674AbRE0BKy>;
	Sat, 26 May 2001 21:10:54 -0400
Message-Id: <200105270110.DAA2201932@mail.takas.lt>
Date: Sun, 27 May 2001 03:07:54 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: [PATCH] fix typos in Configure.help
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.4.5-ac1:

--- Configure.help.orig Sun May 27 02:53:12 2001
+++ Configure.help      Sun May 27 03:02:50 2001
@@ -12648,7 +12648,7 @@
 Default NLS Option
 CONFIG_NLS_DEFAULT
   The default NLS used when mounting file system. Note, that this is
-  the NLS used by your console, not the NLS used by a specyfic file
+  the NLS used by your console, not the NLS used by a specific file
   system (if different) to store data (filenames) on a disk.
   Currently, the valid values are:
   big5, cp437, cp737, cp775, cp850, cp852, cp855, cp857, cp860, cp861,
@@ -12745,7 +12745,7 @@
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage for Turkish.

-Codepage 860 (Portugese)
+Codepage 860 (Portuguese)
 CONFIG_NLS_CODEPAGE_860
   The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
@@ -12847,7 +12847,7 @@
   DOS/Windows partitions correctly. This does apply to the filenames
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage for Russian and
-  Bulgarian and Belorussian.
+  Bulgarian and Belarussian.

 Japanese charsets (Shift-JIS, EUC-JP)
 CONFIG_NLS_CODEPAGE_932
@@ -13001,8 +13001,8 @@
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the Latin 8 character
   set, which adds the last accented vowels for Welsh (aka Cymraeg)
-  (and Manx Gaelic) hat were missing in Latin 1.
-  <http://linux.speech.cymru.org/>has further information.
+  (and Manx Gaelic) that were missing in Latin 1.
+  <http://linux.speech.cymru.org/> has further information.

 NLS ISO 8859-15 (Latin 9; Western European Languages with Euro)
 CONFIG_NLS_ISO8859_15


