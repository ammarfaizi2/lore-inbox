Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269980AbUJNHCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269980AbUJNHCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 03:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbUJNHCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 03:02:25 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58050 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269980AbUJNHCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 03:02:22 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_14_Oct_2004_07_02_16_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041014070216.E7F04C9711@merlin.emma.line.org>
Date: Thu, 14 Oct 2004 09:02:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.231, 2004-10-14 08:58:37+02:00, samel@mail.cz
  shortlog: 3 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    3 +++
 1 files changed, 3 insertions(+)

##### GNUPATCH #####
--- 1.202/shortlog	2004-10-11 05:13:47 +02:00
+++ 1.203/shortlog	2004-10-14 08:58:06 +02:00
@@ -276,6 +276,7 @@
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
+'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
@@ -1322,6 +1323,7 @@
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
 'laforge:org.rmk.(none)' => 'Harald Welte', # guessed
+'lars.ellenberg:linbit.com' => 'Lars Ellenberg',
 'lathiat:sixlabs.org' => 'Trent Lathiat Lloyd',
 'latten:austin.ibm.com' => 'Joy Latten',
 'laubrycomm:free.fr' => 'Ludovic Aubry',
@@ -2096,6 +2098,7 @@
 'spyro:com.rmk.(none)' => 'Ian Molton',
 'spyro:f2s.com' => 'Ian Molton',
 'src:flint.arm.linux.org.uk' => 'Russell King',
+'sreenib:lsil.com' => 'Sreenivas Bagalkote',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAHgkbkECA7WU327aMBTGr/FTWOoFFx3h2M5/iarQVhtqpVVUfQCTHEKEEyPbpWzKwzcB
AaPbLrZ1SW58fD77O+ennAs6vU17TpuNVLm9XmNdvJS154ysbYVOepmumpulrAt8QtdwAN6+
jAsIg6ThSRgEDXIMgsxnch7FEWacXNBniybtVdK5ZSmtJ+vcILbxL9q6tFdUWy/vljOt2+Vw
I81wXroV4hrNcHI/WKGpUQ2c1sqSNu9RumxJN2hs2mOeOEbctzWmvdnd5+eH8YyQ0YgerdLR
iHxwWafj1lkSgadtrjxtivODfAaMgWDCjxqASETkljKPC0bBHzIYMp9CnAZxKqJL4CkAtbJC
dV3JUnnZd3rJ6ADIhH6w+RuSUbvUxildpFTQGl+pzFss1qIl9zQMeBySx1MDyeAPH0JAArk6
GV/qCt+5PjjYmw5YDJEfsbgRLEqCZoGJXGQRJBIwl/P8vDNn4q7LfltvDGHDOUuCHf1Dxhn8
f7bxe/DvHR24M/DDYM8dxHvuEP6au/hv3H+mvW/ZVzowr9vuG2xb9Idq/oL8lEcxZaS/+9Fl
WusNKtX57dPRFe2Pd2E6NllnXpX9T2TKBPc7iZLGem021nM0RarKuh0FJ+lDu03vDtudkEOy
u8u2I6Uu56my5Q9XPe2iG2npRBZSrbTDVnScGNkSs5V9qUb+AoQvgJM3zT9/AgIFAAA=

