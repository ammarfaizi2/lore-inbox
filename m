Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbTIUEwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 00:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTIUEwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 00:52:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:34277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262329AbTIUEwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 00:52:35 -0400
Date: Sat, 20 Sep 2003 21:51:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gaxt <gaxt@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm3 VFAT File system problem
Message-Id: <20030920215152.5e5b318c.rddunlap@osdl.org>
In-Reply-To: <3F6C543D.7080706@rogers.com>
References: <3F6C543D.7080706@rogers.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Sep 2003 09:21:01 -0400 gaxt <gaxt@rogers.com> wrote:

| Upon moving from -mm2 to -mm3, my vfat filesystems did not automatically 
| bount at bootup as per the fstab and could not be accessed by 
| applications in Gnome ie. my mount point showed no subdirectories or files.
| 
| I could manually mount (not by mount /mnt/win_c but by the full mount -t 
| vfat /dev/hda1 /mnt/win_c) and I could explore using ls in terminals but 
| programs in Gnome could not open the filesystem.
| 
| Upon rebooting into -mm2 everything was fine again.

Please post your /etc/fstab file.

Thanks,
--
~Randy
