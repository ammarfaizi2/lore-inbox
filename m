Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWELMy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWELMy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWELMy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:54:58 -0400
Received: from mta07.mail.t-online.hu ([195.228.240.52]:9708 "EHLO
	mta07.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S1751221AbWELMy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:54:57 -0400
Subject: [PATCH] i386: Trivial typo fixes
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: trivial-list <trivial@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 14:54:53 +0200
Message-Id: <1147438493.27820.17.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial typo fixes in Kconfig files (i386).

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

 linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/i386/Kconfig                    |    2 +-
 linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/i386/Kconfig.cpu                |    2 +-

--

diff -puN arch/i386/Kconfig~kconfig-i18n-22-typo-fixes arch/i386/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/arch/i386/Kconfig~kconfig-i18n-22-typo-fixes  2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/i386/Kconfig     2006-05-12 12:43:50.000000000 +0200
@@ -716,7 +716,7 @@ config KEXEC
        help
          kexec is a system call that implements the ability to shutdown your
          current kernel, and to start another kernel.  It is like a reboot
-         but it is indepedent of the system firmware.   And like a reboot
+         but it is independent of the system firmware.   And like a reboot
          you can start any kernel with it, not just Linux.
 
          The name comes from the similiarity to the exec system call.
diff -puN arch/i386/Kconfig.cpu~kconfig-i18n-22-typo-fixes arch/i386/Kconfig.cpu
--- linux-2.6.17-rc4-i18n-kconfig/arch/i386/Kconfig.cpu~kconfig-i18n-22-typo-fixes      2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/i386/Kconfig.cpu 2006-05-12 12:43:50.000000000 +0200
@@ -41,7 +41,7 @@ config M386
          - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
          - "Geode GX/LX" For AMD Geode GX and LX processors.
          - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
-         - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
+         - "VIA C3-2" for VIA C3-2 "Nehemiah" (model 9 and above).
 
          If you don't know what to do, choose "386".
 

_

