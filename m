Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275062AbRIYQDM>; Tue, 25 Sep 2001 12:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRIYQDC>; Tue, 25 Sep 2001 12:03:02 -0400
Received: from [212.59.31.66] ([212.59.31.66]:6876 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S275062AbRIYQCy>;
	Tue, 25 Sep 2001 12:02:54 -0400
Date: Tue, 25 Sep 2001 17:23:03 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: all files are executable in vfat
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.64 'Sparc', compiled for Linux 2.4.7 i686
Message-ID: <ISPFE83Y8pEBtKarvzr000007ff@mail.takas.lt>
X-OriginalArrivalTime: 25 Sep 2001 16:01:16.0963 (UTC) FILETIME=[4F0F1F30:01C145DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

All files are executable in vfat (kernel 2.4.10), although I have
/dev/hda1  /mnt/c   vfat   defaults,user,noexec,umask=0,quiet 0 0
in /etc/fstab. They were not in 2.4.7.

Regards,
Nerijus

