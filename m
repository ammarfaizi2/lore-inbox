Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTHYLDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbTHYLDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:03:42 -0400
Received: from vsmtp1.tin.it ([212.216.176.221]:28824 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S261697AbTHYLDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:03:38 -0400
Date: Mon, 25 Aug 2003 13:11:01 +0200
From: Alessandro Salvatori <a.salvatori@universitari.crocetta.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test4-bk2] depmod: *** Unresolved symbols
Message-Id: <20030825131101.25794e92.a.salvatori@universitari.crocetta.org>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lunexia:/usr/src/linux-2.6.0-test4-bk2# make modules_install > /dev/null
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test4-bk2/kernel/fs/ext3/ext3.ko
depmod:         journal_init_inode
depmod:         journal_init_dev
depmod:         journal_force_commit
depmod:         journal_create
depmod:         journal_dirty_data
depmod:         log_wait_commit
depmod:         journal_restart
depmod:         journal_start_commit
depmod:         journal_extend
depmod:         journal_update_format
depmod:         journal_get_undo_access
depmod:         journal_lock_updates
depmod:         journal_errno
depmod:         journal_flush
depmod:         journal_start
depmod:         journal_blocks_per_page
depmod:         journal_abort
depmod:         journal_clear_err
depmod:         journal_invalidatepage
depmod:         journal_destroy
depmod:         journal_check_available_features
depmod:         journal_load
depmod:         journal_get_write_access
depmod:         journal_revoke
depmod:         journal_get_create_access
depmod:         journal_release_buffer
depmod:         journal_try_to_free_buffers
depmod:         journal_stop
depmod:         journal_wipe
depmod:         journal_unlock_updates
depmod:         journal_forget
depmod:         journal_dirty_metadata
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test4-bk2/kernel/fs/msdos/msdos.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test4-bk2/kernel/fs/vfat/vfat.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat__get_entry
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_search_long
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
