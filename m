Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbTBSPiw>; Wed, 19 Feb 2003 10:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBSPiw>; Wed, 19 Feb 2003 10:38:52 -0500
Received: from matav-3.matav.hu ([145.236.252.34]:45370 "EHLO
	Milos.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S268940AbTBSPiv>; Wed, 19 Feb 2003 10:38:51 -0500
Message-ID: <3E53A75B.80000@narancs.tii.matav.hu>
Date: Wed, 19 Feb 2003 16:48:43 +0100
From: narancs <narancs@narancs.tii.matav.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.2.1) Gecko/20021130
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (Maybe a little off...) Choosing filesystem type for production servers
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all people!

sorry to disturb you with such silly questions, but we are making 
long-term decisions at our company choosing the company's standard FS 
for linux servers' filesystem.

As now we chose linux kernel 2.4.20 for production systems, we have to 
decide which fs to use.

What I need from you folks is suggestions regarding which suits our 
needs the best.
Points:

- stable, reliable, journaling
- extendable, can be exteneded, reduced, also with LVM
- fast i/o, file access
- use with SMP systems
- easy to backup and restore

We have more experience with ext2, ext3, reiser, less with jfs, xfs.
But we do not have sight in depths.

I do NOT intend to start a flamewar in LKML between fs fans, so if you 
fell so, private mails are appreciated.

Thank you very much!

Narancs



