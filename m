Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266408AbUFQHpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUFQHpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 03:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUFQHpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 03:45:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:64759 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266408AbUFQHpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 03:45:51 -0400
From: Patrick Dreker <patrick@dreker.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: CREDITS update [Re: Formal apology.]
Date: Thu, 17 Jun 2004 09:45:27 +0200
User-Agent: KMail/1.6.2
Cc: Plaz McMan <PlazMcMan@Softhome.net>, linux-kernel@vger.kernel.org
References: <1087443094.1332.10.camel@ansel.lan> <20040616203257.52144aa0.rddunlap@osdl.org>
In-Reply-To: <20040616203257.52144aa0.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406170945.41696.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 17. Juni 2004 05:32 schrieb Randy.Dunlap:
> On Wed, 16 Jun 2004 20:31:34 -0700 Plaz McMan wrote:
> | I would like to formally apologize for my comments regarding the late
> | Leonard Zubkoff. I had no idea of his death, and in light of this, my
> | remarks were totally inappropriate.
> |
> | I am very sorry.
>
> I'll accept your apology.  Hopefully others will also (but
> not all on lkml.....).
Would something like the following patch be OK in order to avoid such an 
embarrissing mistake in the future? (against 2.6.7)

Signed-off-by: Patrick Dreker <patrick@dreker.de>

Patrick

- --- linux/CREDITS	2004-06-16 07:19:43.000000000 +0200
+++ linux/CREDITS.new	2004-06-17 09:26:54.000000000 +0200
@@ -3579,6 +3579,7 @@
 
 N: Leonard N. Zubkoff
 W: http://www.dandelion.com/Linux/
+D: Leonard died in a helicopter crash in Alaska on August 29, 2002
 D: BusLogic SCSI driver
 D: Mylex DAC960 PCI RAID driver
 D: Miscellaneous kernel fixes
@@ -3600,5 +3601,5 @@
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the 
 # last entry, and he'll get positively pissed if he can't even
- -# be second-to-last.  (and this file really _is_ supposed to be
+# be third-to-last.  (and this file really _is_ supposed to be
 # in alphabetic order)

- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0UwlcERm2vzC96cRAmkeAJ4pAQdIxtAG3qLd0BzTk5eqFZhyEgCfYmAM
ZEiFMjYpTdB1tJ+gXKraVlY=
=c7Ec
-----END PGP SIGNATURE-----
