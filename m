Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWAPQp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWAPQp4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAPQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:45:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31130 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751100AbWAPQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:45:55 -0500
Subject: PATCH: Remove enable.h from rio (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:50:07 +0000
Message-Id: <1137430207.15553.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/enable.h linux-2.6.15-git12/drivers/char/rio/enable.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/enable.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/enable.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,48 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******               E N A B L E   H E A D E R S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_enable_h_sccs = "@(#)enable.h	1.1";
-#endif
-#endif
-
-
-#define ENABLE_LTT  TRUE
-#define ENABLE_LRT  TRUE
-
-
-/*********** end of file ***********/

