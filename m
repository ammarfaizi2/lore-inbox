Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTL1LYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTL1LYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:24:18 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:13061 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265080AbTL1LYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:24:17 -0500
To: "Kevin Krieser" <kkrieser@lcisp.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
Mail-Copies-To: nobody
References: <011801c3cd34$239b0020$6e01a8c0@athlon2400>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sun, 28 Dec 2003 12:23:56 +0100
In-Reply-To: <011801c3cd34$239b0020$6e01a8c0@athlon2400> (Kevin Krieser's
 message of "Sun, 28 Dec 2003 05:17:11 -0600")
Message-ID: <plopm365g118z7.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kevin!

Sun, 28 Dec 2003 05:17:11 -0600, you wrote: 

 > XP came with an option that I've seen on USB hard drives where it won't
 > cache writes by default.  It is in Device Manager, and called Optimize
 > for quick removal.  You can also enable write caching, which requires
 > the use of the Safe Removal icon.

 > I don't recall 2000 having this option.

 > With Linux, I'm just ingrained to umount first.

Or with  Linux, you can  use the "sync"  mount option (or  dirsync) to
force direct write of data.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
