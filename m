Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbSJaP4Z>; Thu, 31 Oct 2002 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJaP4Y>; Thu, 31 Oct 2002 10:56:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12045 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262590AbSJaP4Y>; Thu, 31 Oct 2002 10:56:24 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21545.509551.601735@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:02:49 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [0/8] overview
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: JFK ECHELON Ft. Bragg Saddam Hussein White Water Qaddafi Nazi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This message starts set of 8 patches against your current BK tree to
include reiser4.

Changes to the core code are fairly small and trivial: mostly function
exports, plus one patch to share ->journal_info pointer with Ext3.

All patches are available at http://namesys.com/snapshots/2002.10.31/,
they can be applied in any order.

Utilities, including mkfs.reiser4 are available at
http://namesys.com/snapshots/2002.10.31/reiser4progs-0.1.0.tar.gz

Nikita.
