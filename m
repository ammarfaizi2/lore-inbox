Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318142AbSHIEBP>; Fri, 9 Aug 2002 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSHIEBP>; Fri, 9 Aug 2002 00:01:15 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:36739 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S318142AbSHIEBN>; Fri, 9 Aug 2002 00:01:13 -0400
Date: Thu, 8 Aug 2002 21:04:56 -0700
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: ext3 journal/IDE problems ?
Message-ID: <20020809040456.GA786@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

What's going on with this ?

I get:

===========================================================

EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753210
Aborting journal on device ide0(3,5).
Remounting filesystem read-only
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753211
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753212
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753213
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753214
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753215
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753216
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753217
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753218
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753219
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753220
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753221
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753222
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753223
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753224
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753225
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753226
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753227
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753228
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753229
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753230
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753231
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753232
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753233
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753234
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753235
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753236
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753237
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753238
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753239
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753240
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753241
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753242
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753243
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753244
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753245
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753246
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753247
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753248
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753249
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753250
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753251
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753252
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753253
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753254
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753255
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753256
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753257
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753258
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753259
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753260
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753261
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753262
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753263
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753264
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753265
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753266
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753267
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753268
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753269
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753270
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753271
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753272
EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753273
ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device ide0(3,5)) in ext3_free_blocks: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device ide0(3,5)) in ext3_truncate: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device ide0(3,5)) in ext3_orphan_del: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide0(3,5)) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device ide0(3,5)) in ext3_delete_inode: Journal has aborted

===========================================================
