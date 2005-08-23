Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVHWRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVHWRBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVHWRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:01:20 -0400
Received: from ns.netcenter.hu ([195.228.254.57]:64940 "EHLO netcenter.hu")
	by vger.kernel.org with ESMTP id S932226AbVHWRBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:01:19 -0400
From: info@netcenter.hu
Message-ID: <03b601c5a804$305d8ce0$0400a8c0@LocalHost>
To: <linux-kernel@vger.kernel.org>
Subject: message: do_vfs_lock: VFS is out of sync with lock manager!
Date: Tue, 23 Aug 2005 19:00:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list, developers!

I have seriously get this message:

[43124719.930000] do_vfs_lock: VFS is out of sync with lock manager!
[43124720.940000] do_vfs_lock: VFS is out of sync with lock manager!
[43124721.950000] do_vfs_lock: VFS is out of sync with lock manager!
[43124722.960000] do_vfs_lock: VFS is out of sync with lock manager!
[43124723.970000] do_vfs_lock: VFS is out of sync with lock manager!

And I dont know what list is good for this exactly...

Kernel: 2.6.13-rc6

Only two FS:

1 NFS (root-fs)
2. XFS (GNBD-device)

Thanks

Janos
