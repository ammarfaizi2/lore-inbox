Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSH0Xrt>; Tue, 27 Aug 2002 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSH0Xrt>; Tue, 27 Aug 2002 19:47:49 -0400
Received: from u212-239-153-153.dialup.planetinternet.be ([212.239.153.153]:38660
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S317371AbSH0Xrs>; Tue, 27 Aug 2002 19:47:48 -0400
Message-Id: <200208272350.g7RNonq0009325@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Date: Wed, 28 Aug 2002 01:50:49 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling 2.5.32 IDE as a module results in:

 ide.c:3809: redefinition of `init_module'
 ide.c:3787: `init_module' previously defined here
 {standard input}: Assembler messages:
 {standard input}:9441: Error: symbol `init_module' is already defined
 make[2]: *** [ide.o] Error 1
 make[2]: Leaving directory `/usr/src/linux/drivers/ide'
 make[1]: *** [ide] Error 2
 make[1]: Leaving directory `/usr/src/linux/drivers'
 make: *** [drivers] Error 2

MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

