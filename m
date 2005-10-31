Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVJaAz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVJaAz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJaAz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:55:27 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:63179 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932390AbVJaAz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:55:26 -0500
Date: Sun, 30 Oct 2005 19:55:28 -0500
From: Bob Picco <bob.picco@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, ak@muc.de,
       clemens@ladisch.de, venkatesh.pallipadi@intel.com, bob.picco@hp.com
Subject: [PATCH] HPET, Maintainers
Message-ID: <20051031005528.GD6019@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch identifies the HPET Maintainers.  Clemens in taking over as
primary maintainer for the HPET driver.  Clemens has i386 hardware with HPET
and is a better choice than me because of this.  I've shared this patch
with all cc: recipients and there is agreement on ownership.  Hopefully this
eliminates future confusion in terms of where HPET maintenance is owned.

thanks,

bob

Signed-off-by: Bob Picco <bob.picco@hp.com>

 MAINTAINERS |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: linux-2.6.14/MAINTAINERS
===================================================================
--- linux-2.6.14.orig/MAINTAINERS	2005-10-28 14:24:57.000000000 -0400
+++ linux-2.6.14/MAINTAINERS	2005-10-30 19:31:35.000000000 -0500
@@ -1060,6 +1060,26 @@ P:	Jaroslav Kysela
 M:	perex@suse.cz
 S:	Maintained
 
+HPET:	High Precision Event Timers driver (hpet.c)
+P:	Clemens Ladisch
+M:	clemens@ladisch.de 
+S:	Maintained
+
+HPET:	i386
+P:	Venkatesh Pallipadi (Venki)
+M:	venkatesh.pallipadi@intel.com
+S:	Maintained
+
+HPET:	x86_64
+P:	Andi Kleen and Vojtech Pavlik
+M:	ak@muc.de and vojtech@suse.cz
+S:	Maintained
+
+HPET:	ACPI hpet.c
+P:	Bob Picco
+M:	bob.picco@hp.com
+S:	Maintained
+
 HPFS FILESYSTEM
 P:	Mikulas Patocka
 M:	mikulas@artax.karlin.mff.cuni.cz
