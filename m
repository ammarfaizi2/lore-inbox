Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWAPQwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWAPQwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWAPQwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:52:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41951 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751115AbWAPQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:52:12 -0500
Subject: PATCH: Remove mesg.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:56:16 +0000
Message-Id: <1137430576.15553.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/mesg.h linux-2.6.15-git12/drivers/char/rio/mesg.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/mesg.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/mesg.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,41 +0,0 @@
-/*
-** -----------------------------------------------------------------------------
-**
-**  Perle Specialix driver for Linux
-**  Ported from existing RIO Driver for SCO sources.
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
-**
-**	Module		: mesg.h
-**	SID		: 1.2
-**	Last Modified	: 11/6/98 11:34:12
-**	Retrieved	: 11/6/98 11:34:21
-**
-**  ident @(#)mesg.h	1.2
-**
-** -----------------------------------------------------------------------------
-*/
-
-#ifndef __rio_mesg_h__
-#define	__rio_mesg_h__
-
-#ifdef SCCS_LABELS
-static char *_mesg_h_sccs_ = "@(#)mesg.h	1.2";
-#endif
-
-
-#endif				/* __rio_mesg_h__ */

