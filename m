Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271663AbRHQOWC>; Fri, 17 Aug 2001 10:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRHQOVw>; Fri, 17 Aug 2001 10:21:52 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:33039 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id <S271662AbRHQOVl>; Fri, 17 Aug 2001 10:21:41 -0400
Date: Fri, 17 Aug 2001 15:21:52 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: broken memory chip -> software fix?
Message-ID: <20010817152152.A60387@compsoc.man.ac.uk>
In-Reply-To: <20010817161505.A25194@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010817161505.A25194@clipper.ens.fr>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 04:15:05PM +0200, David Madore wrote:

> Hi all.
> 
> I have a broken bit in my memory - at address 0x04d5ae38 if you want
> to know the details (bit 29 of the double word there sometimes reads
> as 1 when it was written as 0, in particular if bit 15 is at 1).  I
> discovered this by observing a one-bit corruption of some files, and
> diagnosed it by running memtest86.

badRAM patch linked from kernelnewbies.org/patches (please check there first
in the future, most things should be listed).

> translation?  If so, how?  I would prefer not to have to patch the
> kernel, if at all possible.

it's not

regards
john

-- 
"This bulletin discusses three security vulnerabilities that are
 unrelated except in the sense that both affect ISA Server 2000"
	- Microsoft Product Security
