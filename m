Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbRGQAYo>; Mon, 16 Jul 2001 20:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbRGQAYf>; Mon, 16 Jul 2001 20:24:35 -0400
Received: from attila.bofh.it ([213.92.8.2]:9170 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S267744AbRGQAY1>;
	Mon, 16 Jul 2001 20:24:27 -0400
Date: Tue, 17 Jul 2001 02:24:05 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: nfs_refresh_inode: inode number mismatch
Message-ID: <20010717022405.A22156@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jul 18 00:15:07 newsserver kernel: nfs_refresh_inode: inode number mismatch
Jul 18 00:15:07 newsserver kernel: expected (0x3b30ac75/0x48d5), got (0x3b30ac75/0x8d04)

I've got a flood of these messages while talking to a procom NAS this.
Should I worry? Upgrade/patch the kernel? Yell at procom tech support?


Linux newsserver 2.4.5 #1 Fri Jun 22 18:18:56 CEST 2001 i686 unknown

192.168.139.11:/news_store on /shared/archive type nfs (rw,noatime,rsize=8192,wsize=8192,udp,nfsvers=3,addr=192.168.139.11)


-- 
ciao,
Marco
