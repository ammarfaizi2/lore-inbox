Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132048AbRBOBHK>; Wed, 14 Feb 2001 20:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132049AbRBOBHA>; Wed, 14 Feb 2001 20:07:00 -0500
Received: from nic-31-c31-100.mn.mediaone.net ([24.31.31.100]:4224 "EHLO
	nic-31-c31-100.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S132048AbRBOBGt>; Wed, 14 Feb 2001 20:06:49 -0500
Date: Wed, 14 Feb 2001 19:06:27 -0600 (CST)
From: "Scott M. Hoffman" <scott@mediaone.net>
X-X-Sender: <scott@nic-31-c31-100.mn.mediaone.net>
Reply-To: <scott1021@mediaone.net>
To: <linux-kernel@vger.kernel.org>
Subject: crash 5/5 w/ memtest86
Message-ID: <Pine.LNX.4.32.0102141857410.1021-100000@nic-31-c31-100.mn.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  After getting several segfaults running fetchmail, I tried memtest86 for
the first time on my PC (Celeron 500, i810m/b from e-machines).  Five out
of five tries from two different floppy disks crashed at 6% into test 1.
  I suspected a new PC133 memory stick, but the test failed at the same
point without it.  My system has run fine with this for at least five
days, I only noticed a problem after an oops last night, after upgrading
to the 2.4.2-pre3 kernel yesterday morning.
  Is there any other way to test whether this may be a memory problem or
something else, besides gettig more ram or a different motherboard?
  I do have an strace of one SIGSEGV from a fetchmail run, if it might
help.

Thanks,
Scott

