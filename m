Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRHKCEu>; Fri, 10 Aug 2001 22:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266067AbRHKCEk>; Fri, 10 Aug 2001 22:04:40 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:59653 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S265402AbRHKCEf>; Fri, 10 Aug 2001 22:04:35 -0400
Date: Sat, 11 Aug 2001 03:04:43 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: complete_and_exit
Message-ID: <20010811030442.A5238@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.7-linus contains the completion code, but not complete_and_exit().

2.4.7-ac contains complete_and_exit() as well, replacing up_and_exit().

Is complete_and_exit() going to be in 2.4.8 ? Trying to support before and
after the change is really more of a pain than it could be right now, as
you can't use LINUX_VERSION_CODE to detect ac kernels.

thanks
john

-- 
"We're standing there pounding a dead parrot on the counter, and
 the management response is to frantically swap in new counters to
 see if that fixes the problem."
	- Peter Gutmann
