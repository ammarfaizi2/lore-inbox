Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDPTzr>; Mon, 16 Apr 2001 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDPTz1>; Mon, 16 Apr 2001 15:55:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3078 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132039AbRDPTzU>;
	Mon, 16 Apr 2001 15:55:20 -0400
Date: Mon, 16 Apr 2001 16:55:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: 2.4.3-ac{6,7} LVM hang
Message-ID: <Pine.LNX.4.21.0104161653140.14442-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.3-ac4 seems to work great on my test box (UP K6-2 with SCSI
disk), but 2.4.3-ac6 and 2.4.3-ac7 hang pretty hard when I try
to access any of the logical volumes on my test box.

The following changelog entry in Linus' changelog suggests me
whom to bother:   ;)
 - Jens Axboe: LVM and loop fixes

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

