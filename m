Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266637AbUAWWPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266641AbUAWWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:15:48 -0500
Received: from k1.dinoex.de ([80.237.200.138]:60898 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S266637AbUAWWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:15:46 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [2.6, TRIVIAL, DOC] Documentation/Changes update
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Fri, 23 Jan 2004 23:06:20 +0100
Message-ID: <87ektq8gmb.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch removes references to kernel 2.4 and to translations that
are outdated for 2.6 (german translation is at 2.4.20) or hosts that
are not available.

Jochen

--- linux-2.6.1/Documentation/Changes.jh	2004-01-23 23:00:22.000000000 +0100
+++ linux-2.6.1/Documentation/Changes	2004-01-23 23:02:46.000000000 +0100
@@ -15,24 +15,10 @@
 Axel Boldt, Alessandro Sigala, and countless other users all over the
 'net).
 
-The latest revision of this document, in various formats, can always
-be found at <http://cyberbuzz.gatech.edu/kaboom/linux/Changes-2.4/>.
-
 Feel free to translate this document.  If you do so, please send me a
 URL to your translation for inclusion in future revisions of this
 document.
 
-Smotrite file <http://oblom.rnc.ru/linux/kernel/Changes.ru>, yavlyaushisya
-russkim perevodom dannogo documenta.
-
-Visite <http://www2.adi.uam.es/~ender/tecnico/> para obtener la traducción
-al español de este documento en varios formatos.
-
-Eine deutsche Version dieser Datei finden Sie unter
-<http://www.stefan-winter.de/Changes-2.4.0.txt>.
-
-Last updated: October 29th, 2002
-
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
 Current Minimal Requirements

-- 
#include <~/.signature>: permission denied
