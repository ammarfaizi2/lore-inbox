Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265398AbRFVNJN>; Fri, 22 Jun 2001 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265399AbRFVNJC>; Fri, 22 Jun 2001 09:09:02 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:28168 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S265398AbRFVNIw>;
	Fri, 22 Jun 2001 09:08:52 -0400
Date: Fri, 22 Jun 2001 16:08:49 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <reiserfs-list@namesys.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Incompatibility between the reisrefs patches for 2.2.x and 2.4.x
Message-ID: <Pine.LNX.4.33.0106221603590.24521-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is a know issue, but nonetheless.....
I have dual coppermine/930 machine with 1.2G ram, kernel 2.4.5. I used
reiserfs for my  /home and /var partitions. When tried downgrading to
2.2.19, I got errors  in syslog like 'can't find superblock' ... ( I don't
have them, /var wasn't mounted, and i had to return the machine in
production state... ). Does someone has any idea about this, how could I
downgrade to 2.2.19 ?

