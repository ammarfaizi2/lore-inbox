Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263906AbTKSQMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbTKSQMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:12:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26833 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263906AbTKSQMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:12:50 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.195
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Nov_19_16_12_48_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031119161248.764309550D@merlin.emma.line.org>
Date: Wed, 19 Nov 2003 17:12:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.195 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://kernel.bkbits.net/torvalds/tools/

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.195
date: 2003/11/19 16:08:02;  author: emma;  state: Exp;  lines: +5 -1
Add 2nd address of Atul Mukker of LSI Logic.
----------------------------
revision 0.194
date: 2003/11/11 09:21:00;  author: vita;  state: Exp;  lines: +14 -1
10 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.194
retrieving revision 0.195
diff -u -r0.194 -r0.195
--- lk-changelog.pl	11 Nov 2003 09:21:00 -0000	0.194
+++ lk-changelog.pl	19 Nov 2003 16:08:02 -0000	0.195
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.194 2003/11/11 09:21:00 vita Exp $
+# $Id: lk-changelog.pl,v 0.195 2003/11/19 16:08:02 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -233,6 +233,7 @@
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'atulm:lsil.com' => 'Atul Mukker',
+'atul.mukker:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -2127,6 +2128,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.195  2003/11/19 16:08:02  emma
+# Add 2nd address of Atul Mukker of LSI Logic.
+#
 # Revision 0.194  2003/11/11 09:21:00  vita
 # 10 new addresses
 #

