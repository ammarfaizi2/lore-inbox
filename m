Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTGLJ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 05:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270004AbTGLJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 05:27:24 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20435 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270003AbTGLJ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 05:27:22 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: <lista1@telia.com>, <axboe@suse.de>
Subject: Re: 2.5.75 does not boot - TCQ oops
Date: Sat, 12 Jul 2003 03:51:07 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307120351.07599.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ Voluspa wrote: ]
> I took home 2.5.75-bk1, applied the tcq patch and then used the computer
> for five hours in the TCQ+TASKFILE environment. Filesystem is ext2. 
....
>
> No hickups. Except...
>======================================================

What would be the best approach to track down the problem?
I've recovered 99% of my system.
(rpm -V is a wonderful thing together with wget).

I intend to convert my root filesystem from reiserfs to xfs tomorrow
for the purposes of testing (and because I've had too many problems with 
reiser over time). Should I do this, and re-test TCQ to avoid any reiser 
problems, or should I stick with the current setup and do more testing as 
needed. I'll have to figure out some precautions if so :)
How can I help? 

On the good side, fs corruption dug out 10 gigs of free space
I never would have thought were available....cleanup for free.




