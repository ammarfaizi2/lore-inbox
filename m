Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131383AbQKNXOO>; Tue, 14 Nov 2000 18:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbQKNXOE>; Tue, 14 Nov 2000 18:14:04 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:5636 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S131383AbQKNXN7>;
	Tue, 14 Nov 2000 18:13:59 -0500
Message-ID: <3A11C123.84DE0A95@windeath.2y.net>
Date: Tue, 14 Nov 2000 16:48:03 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, twaugh@redhat.com, wollny@cns.mpg.de
Subject: Parport/IMM/Zip Oops Revisited -- Filesys problem? Viro please look
In-Reply-To: <3A088352.BCAD0B7A@windeath.2y.net> <3A106A88.571AFF9E@windeath.2y.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James M wrote:

   Was just trying to find out why I can mount in 11pre1 and 11pre2 when
Gert can't mount at all, so I removed my VFAT factory formatted zipdisk
and put in an Ext2 formatted one.....**BOOM**

Al, my original oops report is here:

http://boudicca.tux.org/hypermail/linux-kernel/2000week42/1240.html

Summary: Test10 is broken for both filesystems (sick of fsck'n-not
confirmed)
	 11pre1-pre2 work for VFAT broken for EXT2
	 11pre3 is broken for both filesystems

   Anything you want me to try just let me know, I've already been
through about 100 fscks, a few more won't hurt.
   BTW I have a list of 23 common non-obvious files that changed in
test10/11pre1 and 11pre2/pre3, say the word and I'll mail the list.

James M.

--30 Gig of fsck sucks--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
