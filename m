Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266895AbRGMOOa>; Fri, 13 Jul 2001 10:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGMOOK>; Fri, 13 Jul 2001 10:14:10 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:53665 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266895AbRGMOOF>; Fri, 13 Jul 2001 10:14:05 -0400
Message-ID: <3B4F0273.1DF40F8E@uow.edu.au>
Date: Sat, 14 Jul 2001 00:15:15 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> I give up!  I'm getting file system corruption now on the ext3 partition...
> and I've got a kernel oops (soon to be decoded) This is the worst file
> corruption I've ever seen other than having a disk go bad.

There was a truncate-related bug fixed in 0.9.2.  What workload
were you using at the time?
