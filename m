Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSD2Pdn>; Mon, 29 Apr 2002 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSD2Pdm>; Mon, 29 Apr 2002 11:33:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:15371 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S312582AbSD2Pdk>; Mon, 29 Apr 2002 11:33:40 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15565.26578.847909.40612@laputa.namesys.com>
Date: Mon, 29 Apr 2002 19:33:38 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.1{0,1}] VFS: Busy inodes after unmount...
In-Reply-To: <20020429172433.49ad5596.sebastian.droege@gmx.de>
X-Mailer: VM 7.03 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
X-Tom-Swifty: "IBM is up 3 points," Tom said, taking stock of the situation.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege writes:
 > Hi,
 > when rebooting or halting the system I get following message:
 > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
 > 
 > All filesystems are ReiserFS
 > 
 > Any ideas why there are busy inodes after umount?

This problem is known. As I understand Alexander Viro is working on it
right now.

 > 
 > Bye

Nikita.
