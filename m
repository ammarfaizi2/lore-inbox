Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDPPkH>; Mon, 16 Apr 2001 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDPPj6>; Mon, 16 Apr 2001 11:39:58 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:5381 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S129359AbRDPPjt>; Mon, 16 Apr 2001 11:39:49 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Mon, 16 Apr 2001 17:39:42 +0200
To: linux-kernel@vger.kernel.org
Subject: drivers/block/loop.c:max_loop
Message-ID: <20010416173942.G6934@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I run a relatively large FTP server, and I've just reached
the max_loop limit of loop devices here (I use loopback mount of ISO 9660
images of Linux distros here). Is there any reason for keeping
the max_loop variable in loop.c set to 8?

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
