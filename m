Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273256AbRINCNF>; Thu, 13 Sep 2001 22:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273257AbRINCMz>; Thu, 13 Sep 2001 22:12:55 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54004
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273256AbRINCMj>; Thu, 13 Sep 2001 22:12:39 -0400
Date: Thu, 13 Sep 2001 19:12:56 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Comparing release times between 2.2 and 2.4
Message-ID: <20010913191256.A2535@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back I read a message about the overall development of linux
kernels, and there was one question that interested me.

The poster thought that it seemed that the 2.4 kernels were being released
faster than their 2.2 cousins at the same time period.

Well, I took a look, based on timestamps on kernel.org:
2.2:
Jan 26  1999 linux-2.2.0.tar.bz2.sign
Jan 28  1999 linux-2.2.1.tar.bz2.sign
Feb 23  1999 linux-2.2.2.tar.bz2.sign
Mar  9  1999 linux-2.2.3.tar.bz2.sign
Mar 23  1999 linux-2.2.4.tar.bz2.sign
Mar 29  1999 linux-2.2.5.tar.bz2.sign
Apr 16  1999 linux-2.2.6.tar.bz2.sign
Apr 28  1999 linux-2.2.7.tar.bz2.sign
May 11  1999 linux-2.2.8.tar.bz2.sign
May 13  1999 linux-2.2.9.tar.bz2.sign
Jun 14  1999 linux-2.2.10.tar.bz2.sign
Aug  9  1999 linux-2.2.11.tar.bz2.sign
Aug 26  1999 linux-2.2.12.tar.bz2.sign
Oct 20  1999 linux-2.2.13.tar.bz2.sign
Jan  4  2000 linux-2.2.14.tar.bz2.sign
May  4  2000 linux-2.2.15.tar.bz2.sign
Jun  7  2000 linux-2.2.16.tar.bz2.sign
Sep  4  2000 linux-2.2.17.tar.bz2.sign
Dec 11  2000 linux-2.2.18.tar.bz2.sign
Mar 25 19:26 linux-2.2.19.tar.bz2.sign

There were 5 months with multiple kernel releases, and 11 kernels released in
those months which were all before 2.2.13 was released. Four of those months
were before 2.2.9, counting May, with a corresponding 8 kernels released.

2.4:
Jan  4  2001 linux-2.4.0.tar.bz2.sign
Jan 30  2001 linux-2.4.1.tar.bz2.sign
Feb 22  2001 linux-2.4.2.tar.bz2.sign
Mar 30 05:03 linux-2.4.3.tar.bz2.sign
Apr 28 01:43 linux-2.4.4.tar.bz2.sign
May 26 01:26 linux-2.4.5.tar.bz2.sign
Jul  4 00:07 linux-2.4.6.tar.bz2.sign
Jul 20 21:25 linux-2.4.7.tar.bz2.sign
Aug 11 04:13 linux-2.4.8.tar.bz2.sign
Aug 16 18:32 linux-2.4.9.tar.bz2.sign

There have been 3 months with multiple kernel releases, and 6 kernels
released in those months.

Also, 2.2.9 was released in May, while 2.4.9 was released in August.

Another interesting note, 2.3.0 was released in May when 2.2.8 was current,
but 2.2 releases didn't slow until 2.2.{12,13} was released.

These numbers in no way try to determine how much actual development was done
on each series in a time period.  I also didn't factor in lkml email traffic
in those time periods, but that doesn't really tell how much work was done
either.

Some interesting numbers may come from listing the number of patches
submitted during each time period.  Anyone interested?

Mike
