Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTKYDU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTKYDU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:20:29 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:47764 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261974AbTKYDU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:20:27 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.199
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Nov_25_03_20_24_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031125032024.BB17B9D889@merlin.emma.line.org>
Date: Tue, 25 Nov 2003 04:20:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.199 has been released.

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
revision 0.199
date: 2003/11/25 03:20:04;  author: emma;  state: Exp;  lines: +5 -1
New address for Arkadiusz Miskiewicz.
----------------------------
revision 0.198
date: 2003/11/22 14:59:50;  author: emma;  state: Exp;  lines: +5 -1
Add Andreas Beckmann's address.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.198
retrieving revision 0.199
diff -u -r0.198 -r0.199
--- lk-changelog.pl	22 Nov 2003 14:59:50 -0000	0.198
+++ lk-changelog.pl	25 Nov 2003 03:20:04 -0000	0.199
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.198 2003/11/22 14:59:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.199 2003/11/25 03:20:04 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -217,6 +217,7 @@
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
+'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
@@ -2130,6 +2131,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.199  2003/11/25 03:20:04  emma
+# New address for Arkadiusz Miskiewicz.
+#
 # Revision 0.198  2003/11/22 14:59:50  emma
 # Add Andreas Beckmann's address.
 #

