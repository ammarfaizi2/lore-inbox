Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVCQMey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVCQMey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCQMey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 07:34:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31665 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261300AbVCQMeu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 07:34:50 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: bktools::shortlog update
CC: matthias.andree@gmx.de, samel@mail.cz, linux-kernel@vger.kernel.org
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_17_Mar_2005_12_34_45_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050317123445.751E278BFD@merlin.emma.line.org>
Date: Thu, 17 Mar 2005 13:34:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK parent: http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.292, 2005-03-17 13:11:15+01:00, samel@mail.cz
  shortlog: add 4 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    4 ++++
 1 files changed, 4 insertions(+)

##### GNUPATCH #####
--- 1.257/shortlog	2005-03-14 20:52:29 +01:00
+++ 1.258/shortlog	2005-03-17 13:10:58 +01:00
@@ -297,6 +297,7 @@
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
+'andre:tomt.net' => 'Andre Tomt',
 'andrea:cpushare.com' => 'Andrea Arcangeli',
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
@@ -1173,6 +1174,7 @@
 'jack_hammer:adaptec.com' => 'Jack Hammer',
 'jackson:realtek.com.tw' => 'Ian Jackson',
 'jacmet:sunsite.dk' => 'Peter Korsgaard',
+'jacques_basson:myrealbox.com' => 'Jacques Basson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi:telia.com' => 'Jakob Kemi',
 'jakub:redhat.com' => 'Jakub Jelínek',
@@ -2240,6 +2242,7 @@
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rene.rebe:gmx.net' => 'Rene Rebe',
 'rene.scharfe:lsrfire.ath.cx' => 'Rene Scharfe',
+'rene:exactcode.de' => 'Rene Rebe',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
@@ -2435,6 +2438,7 @@
 'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
+'shenkel:gmail.com' => 'Sven Henkel',
 'shep:alum.mit.edu' => 'Tim Shepard',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAGV5OUICA7WUUW+bMBDHn+NPcVIf8tBBbIMDWEqVpp3WtJNWpevz5JhryAq4w06aTnz4
QVBSJeoetnXgB+743/G/+0mcwPRS9pyp1ipP7fgJy8VqWfquUqUt0Clfm6K+yFS5wDt0NaeU
NzfjAR2KpObJUIgaOQqhQ6bmURyh5uQE7i1Wslco57Klsr4q0wqxyV8Z62RvUWz8tA1nxjTh
wK4sDh6xKjEfTG6a43WB54zJLWmEt8rpDNZYWdljfrDPuJcnlL3Zx0/3n89nhIxGsPcKoxF5
57mO5hl3cxy2ETRgIUtE06kehkOekEtgPk84UDGgwYBFwALJmGTilDJJKVhVYD4u1DL39U84
ZeBRMoF3tn5BNNjMVC43CwkqTSGEEp/bpwqtRUtuYBhELCa3rysk3h9ehFBFydmr+cwUeOR8
56IzLlhMo7D5bh2wKBH1AybqQUc0URRTNU8Pt3NQ3G46YpxREdeMhZxt+e8UB/j/2cbv0B/7
2ZLnST0MhOAdeREfkqdSxG+TD/8b+bd5d0v7Al71vGmPt2ng7yb6C/ZTniTASH+7IulM4fwS
XR9GZ9A/b3Pwtcn1P5ApY5Fold+V/rFC+22urDWlLF4qVPncbNpBu7rrTgGTraKt5TzkbW2F
JUrcKO20SbGB0RXMmjTMcI5bbRhErdZmWD5iLhfdrnfN79ZYwtX2VaPe/1R0hvrRropRzBWG
WsfkF7RXK4UmBQAA

