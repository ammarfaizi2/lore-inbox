Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTEaJHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTEaJHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:07:37 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:12006 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S264245AbTEaJHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:07:34 -0400
Date: Sat, 31 May 2003 02:13:35 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Artemio <artemio@artemio.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Xeon processor support
In-Reply-To: <200305311113.32721.artemio@artemio.net>
Message-ID: <Pine.LNX.4.44.0305310204290.31933-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new xeons work fine with 2.4.20. Issues with rtlinux should probably
be directed to fsmlabs or their respective mailing lists...

Outside that what issues are you seeing?

joelja

On Sat, 31 May 2003, Artemio wrote:

> Hello.
> 
> I have a RH7.3-based system with recompiled original 2.4.20 kernel runing on 
> dual 2.4GHz Xeon machine.
> 
> I'd like to know if there is a dedicated Xeon support in 2.4.21-pre? kernels.
> 
> The thing is I'm trying to compile RTLinux for this machine, but it fails to 
> start. The main reason of this is wrong CPU type support in kernel.
> 
> I compiled 2.4.20 for Pentium 4, but new Xeons are a bit different. So is 
> there a dedicated Xeon support in 2.4.21-pre? kernels?
> 
> 
> 
> Thanks.
> 
> 
> Artemio.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


