Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTFLBtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTFLBtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:49:17 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:28935 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264690AbTFLBst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:48:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553833502745@movementarian.org>
Subject: [PATCH 2/4] OProfile: update Changes
In-Reply-To: <10553833504038@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 12 Jun 2003 03:02:31 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QHQ8-00022B-Ao*HGi3F0fBjTo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the version information.

diff -Naur -X dontdiff linux-cvs/Documentation/Changes linux-fixes/Documentation/Changes
--- linux-cvs/Documentation/Changes	2003-05-25 23:13:37.000000000 +0100
+++ linux-fixes/Documentation/Changes	2003-06-12 02:07:08.000000000 +0100
@@ -61,7 +61,7 @@
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  procps                 2.0.9                   # ps --version
-o  oprofile               0.5                     # oprofiled --version
+o  oprofile               0.5.3                   # oprofiled --version
 o  nfs-utils              1.0.3                   # showmount --version
 
 Kernel compilation
@@ -367,7 +367,7 @@
 
 OProfile
 --------
-o  <http://oprofile.sf.net/download.php3>
+o  <http://oprofile.sf.net/download/>
  
 Suggestions and corrections
 ===========================

