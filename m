Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRLWXTP>; Sun, 23 Dec 2001 18:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbRLWXTH>; Sun, 23 Dec 2001 18:19:07 -0500
Received: from [212.159.14.225] ([212.159.14.225]:25560 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S284176AbRLWXSs>; Sun, 23 Dec 2001 18:18:48 -0500
Date: Sat, 22 Dec 2001 16:53:35 +0000
From: Adam Sampson <azz@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.17: typo in Configure.help for CONFIG_PPPOATM
Message-ID: <20011222165335.A9441@cartman.azz.us-lot.org>
Mail-Followup-To: Adam Sampson <azz@gnu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Homepage: http://azz.us-lot.org/
X-Planation: RSA in 2 lines Perl: see http://dcs.ex.ac.uk/~aba/x.html
X-Munition-Export: print pack"C*",split/\D+/,`echo "16iII*o\U@{$/=$z;[(pop,pop,unpack"H*",<>)]}\EsMsKsN0[lN*1lK[d2%Sa2/d0<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<J]dsJxp"|dc`
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious typo.

--- Documentation/Configure.help.orig   Sat Dec 22 16:52:26 2001
+++ Documentation/Configure.help        Sat Dec 22 16:52:36 2001
@@ -6442,7 +6442,7 @@
 CONFIG_PPPOATM
   Support PPP (Point to Point Protocol) encapsulated in ATM frames.
   This implementation does not yet comply with section 8 of RFC2364,
-  which can lead to bad results idf the ATM peer loses state and 
+  which can lead to bad results if the ATM peer loses state and 
   changes its encapsulation unilaterally.
 
 Fusion MPT device support

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
