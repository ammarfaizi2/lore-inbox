Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266676AbUGQBuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266676AbUGQBuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUGQBuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:50:20 -0400
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:12514 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S266676AbUGQBuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:50:17 -0400
Message-ID: <40F885CC.2090709@bigpond.net.au>
Date: Sat, 17 Jul 2004 11:50:04 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Warnings building 2.6.8-rc1 on Fedora Core 2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcc-3.3.3 on a Fedora Core 2 (x86) system I get the following 
warning messages when compiling 2.6.8-rc1:

fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:563: warning: comparison is always false due to limited 
range of data type
fs/smbfs/inode.c:564: warning: comparison is always false due to limited 
range of data type

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

