Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135651AbRBET07>; Mon, 5 Feb 2001 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135650AbRBET0s>; Mon, 5 Feb 2001 14:26:48 -0500
Received: from [212.150.53.130] ([212.150.53.130]:32018 "EHLO
	marcellos.corky.net") by vger.kernel.org with ESMTP
	id <S135614AbRBET0d>; Mon, 5 Feb 2001 14:26:33 -0500
Date: Mon, 5 Feb 2001 21:26:11 +0200
From: Marc Esipovich <marc@corky.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: The CREDITS file.
Message-ID: <20010205212611.A27631@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We've detected a serious bug in the CREDITS file, under normal circumstances
it does not produce visible side effects but may trigger unpredictable results
as soon as Leonard N. Zubkoff (lnz@dandelion.com) sets his eyes on it.

 Patch stream follows:

--- linux-2.4.1/CREDITS Tue Feb  6 04:17:16 2001
+++ linux-2.4.1/CREDITS.orig    Tue Feb  6 04:17:05 2001
@@ -3015,5 +3015,5 @@
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the
 # last entry, and he'll get positively pissed if he can't even
-# be second-to-last.  (and this file really _is_ supposed to be
+# be third-to-last.  (and this file really _is_ supposed to be
 # in alphabetic order)

 bye,
	Marc.

--
marc @ corky.net

fingerprint = D1F0 5689 967F B87A 98EB  C64D 256A D6BF 80DE 6D3C

          /"\
          \ /     ASCII Ribbon Campaign
           X      Against HTML Mail
          / \
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
