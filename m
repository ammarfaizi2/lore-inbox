Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbRGAMK5>; Sun, 1 Jul 2001 08:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbRGAMKh>; Sun, 1 Jul 2001 08:10:37 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:44794 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265111AbRGAMK2>; Sun, 1 Jul 2001 08:10:28 -0400
Message-ID: <3B3F1309.62B3BC@uow.edu.au>
Date: Sun, 01 Jul 2001 22:09:45 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre6 ext3 message
In-Reply-To: <016f01c10222$ab9fba40$b6562341@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
>  2.4.6-pre6 and ext3-2.4-0.0.8-246p5 (had to to hand patch a little).
> 
>  This message popped up on an idle system -- there were no "odd" cronjobs
>  scheduled around this time.  Nobody was logged on.  System had been up for
> a
>  little over a day...first time seeing any messages like this.
>  The source doesn't indicate whether this is serious or just informational.
> 
>  Jun 30 15:58:55 yeti kernel: journal_commit_transaction: odd - more buffers
> 

yeah, sorry.  It's a debug message which escaped from the factory. I keep
on doing that.

It's expected, and there won't be any more.  I promise.

-
