Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279450AbRJWO3Q>; Tue, 23 Oct 2001 10:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279451AbRJWO3G>; Tue, 23 Oct 2001 10:29:06 -0400
Received: from web13107.mail.yahoo.com ([216.136.174.152]:54542 "HELO
	web13107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279450AbRJWO2t>; Tue, 23 Oct 2001 10:28:49 -0400
Message-ID: <20011023142922.57681.qmail@web13107.mail.yahoo.com>
Date: Tue, 23 Oct 2001 07:29:22 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Strange lilo behaviour with kernel 2.4.10/2.4.12 and devfs
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
I'm having a very strange problem with lilo.
I run lilo it looks like it is writing the partition
table but it's not.
Problem begun in 2.4.10 and continued in 2.4.12
I double checked: lilo.config is good running lilo -V
shows that he is reading the config and writes the
partition table as instructed in lilo.conf but after
reboot nothing happens (i.e the new kernel )
I tried different lilo versions (21.7.5 , 22.0.2) and
the behaviour is unchanged

If I boot kernel 2.4.5 surprise lilo is actually
writing the partition table.

Any idea ?

Bye

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
