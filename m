Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRAAVnS>; Mon, 1 Jan 2001 16:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbRAAVnI>; Mon, 1 Jan 2001 16:43:08 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:54795 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129775AbRAAVnB>;
	Mon, 1 Jan 2001 16:43:01 -0500
Message-Id: <200101012222.RAA03212@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.36-2.4.0-prerelease
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2001 17:22:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.0-prerelease is available.

hostfs is more improved.  Writing files really works now.  Executing binaries 
also works.  There is still some memory corruption, though.

I fixed the swapoff crash.

The input to consoles and serial lines is now much more general.  You can 
attach them to ptys, ttys, and ports now, with a few more interfaces to come.

The project's home page is http://user-mode-linux.sourceforge.net

The project's download page is http://sourceforge.net/project/filelist.php?grou
p_id=429

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
