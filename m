Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRH0QEQ>; Mon, 27 Aug 2001 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271773AbRH0QEH>; Mon, 27 Aug 2001 12:04:07 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:23561 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S271767AbRH0QDv>; Mon, 27 Aug 2001 12:03:51 -0400
Date: Mon, 27 Aug 2001 17:04:06 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: module
Message-ID: <20010827170406.B29838@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33L2.0108271826510.32587-100000@zebra.sibnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0108271826510.32587-100000@zebra.sibnet.ro>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 06:51:49PM -0400, sacx@zebra.sibnet.ro wrote:

> Hi,
> 
> 	I'm trying to comunicate some parameters from kernel to a module.
> 	I define a new function somwhere in kernel and after rebuilding
> the version of my function is something like :
> 
> c027b7f0 function_R__ver_function (# cat /proc/ksyms | grep function)
> (somewhere in *.ver files I can see the correct version)

If you're using module versions, then you need to do the necessary build
stuff correctly.

> P.S. I'm a newbie in kernel hacking and I don't want to disturb you but
> if you can help me ... please answer to my email :)))

In that case you should be reading http://kernelnewbies.org and posting
to kernelnewbies@nl.linux.org

regards
john

-- 
"Premature generalization is the root of all evil."
	- Karl Fogel
