Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTATK5O>; Mon, 20 Jan 2003 05:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTATK5O>; Mon, 20 Jan 2003 05:57:14 -0500
Received: from mail.spylog.com ([194.67.35.220]:42432 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S261530AbTATK5N>;
	Mon, 20 Jan 2003 05:57:13 -0500
Date: Mon, 20 Jan 2003 14:06:11 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 and ext3 error.
Message-ID: <20030120110611.GA4862@an.local>
Mail-Followup-To: Andrey Nekrasov <andy@spylog.ru>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Organization: SpyLOG ltd.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

kernel 2.4.20 write (dmesg):

...
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #2853202:
rec_len % 4 != 0 - offset=0, inode=1754302946, rec_len=34858, name_len=134
Aborting journal on device ide2(33,1).
Remounting filesystem read-only
...

why?

-- 
Any statement is incorrect.
