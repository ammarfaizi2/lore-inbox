Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbRE2Wi6>; Tue, 29 May 2001 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbRE2Wis>; Tue, 29 May 2001 18:38:48 -0400
Received: from srvr3.telecom.lt ([212.59.0.2]:31421 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S262295AbRE2Wif>;
	Tue, 29 May 2001 18:38:35 -0400
Reply-To: <nerijusb@takas.lt>
From: "Nerijus Baliunas" <nerijus@users.sourceforge.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fix more typos in Configure.help and fs/nls/Config.in
Date: Wed, 30 May 2001 00:36:38 +0200
Message-ID: <NEBBLCJIPPBPKGHOONKOKENEDOAA.nerijus@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
In-Reply-To: <E154kmj-0004UA-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	Official country name: Belarus
> > 	Language/Nationality: Belarusian
> > 
> > 	Standard has taken things right as we pronounce them.
> > 
> > 	Please apply the patch.
> 
> Done. Thanks for confirming it is correct

You forgot to apply the second part:

--- Config.in.orig      Wed May 30 00:27:45 2001
+++ Config.in   Mon May 28 19:32:25 2001
@@ -29,7 +29,7 @@
   tristate 'Codepage 852 (Central/Eastern Europe)' CONFIG_NLS_CODEPAGE_852
   tristate 'Codepage 855 (Cyrillic)'               CONFIG_NLS_CODEPAGE_855
   tristate 'Codepage 857 (Turkish)'                CONFIG_NLS_CODEPAGE_857
-  tristate 'Codepage 860 (Portugese)'              CONFIG_NLS_CODEPAGE_860
+  tristate 'Codepage 860 (Portuguese)'              CONFIG_NLS_CODEPAGE_860
   tristate 'Codepage 861 (Icelandic)'              CONFIG_NLS_CODEPAGE_861
   tristate 'Codepage 862 (Hebrew)'                 CONFIG_NLS_CODEPAGE_862
   tristate 'Codepage 863 (Canadian French)'        CONFIG_NLS_CODEPAGE_863
 
