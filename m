Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTKNLWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTKNLWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:22:41 -0500
Received: from pop.gmx.net ([213.165.64.20]:1209 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262407AbTKNLWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:22:39 -0500
Date: Fri, 14 Nov 2003 12:22:38 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: new reiser4 snapshot is available
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0020183004@gmx.net
X-Authenticated-IP: [213.23.34.93]
Message-ID: <11745.1068808958@www67.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

4.)-----------------------------------------------------------------
even after aplying the export-* patches from the older snapshot
i still get

  MODPOST
*** Warning: "kswapd" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "destroy_inode" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "nr_free_pagecache_pages" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "inodes_stat" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "balance_dirty_pages_ratelimited" [fs/reiser4/reiser4.ko]
undefined!
*** Warning: "wakeup_kswapd" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "truncate_mapping_pages_range" [fs/reiser4/reiser4.ko]
undefined!
*** Warning: "generic_sync_sb_inodes" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "radix_tree_preload" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "__remove_from_page_cache" [fs/reiser4/reiser4.ko] undefined!
*** Warning: "max_sane_readahead" [fs/reiser4/reiser4.ko] undefined!



best,

svetljo

PS.

please CC me as i'm not subscribed

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

