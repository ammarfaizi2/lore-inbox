Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278800AbRJZRnA>; Fri, 26 Oct 2001 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278795AbRJZRmv>; Fri, 26 Oct 2001 13:42:51 -0400
Received: from intranet.resilience.com ([209.245.157.33]:43004 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S278797AbRJZRmk>; Fri, 26 Oct 2001 13:42:40 -0400
Message-ID: <3BD9AE9D.53D53936@resilience.com>
Date: Fri, 26 Oct 2001 11:42:37 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
In-Reply-To: <Pine.LNX.4.33L.0110261537170.22127-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 26 Oct 2001, Jeff Golds wrote:
> 
> > I've been having this problem since 2.4.6 and just attributed it to VM
> > issues.  However, I've been trying all the latest kernels (2.4.9-acXX,
> > 2.4.10-acXX, 2.4.12-acXX and 2.4.13) and am still getting a deadlock
> > scenario someplace.  In fact, my system hung up in about 2 minutes after
> > booting the 2.4.13 kernel.
> 
> Since your system hangs just after boot, while you still
> have free ram and tons of swap, in kernels with 3 different
> VM subsystems ... I'm pretty sure this isn't a VM problem.

No, it only hung just after boot one time.  However, I was doing a
kernel build when it hung (I was trying to make a new kernel to try out
as I had just rebooted).

Most times, the machine will stay up for a day or two then lock during a
kernel build.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
