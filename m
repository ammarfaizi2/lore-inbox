Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVEQVmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEQVmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEQVmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:42:20 -0400
Received: from smtpout.mac.com ([17.250.248.97]:12485 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261918AbVEQVmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:42:02 -0400
In-Reply-To: <Pine.LNX.3.96.1050517090828.5118A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050517090828.5118A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6A533A3B-685E-46C3-9A2A-948633715B97@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Date: Tue, 17 May 2005 17:41:39 -0400
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2005, at 09:15:52, Bill Davidsen wrote:
> What would be ideal is some cache which didn't depend on power to  
> maintain
> state, like core (remember core?) or the bubble memory which spent  
> almost
> a decade being just slightly too {slow,costly} to replace disk. There
> doesn't seem to be a cost effective technology yet.

I've seen some articles recently on a micro-punchcard technology that  
uses
grids of thousands of miniature needles and sheets of polymer plastic  
that
can be melted at somewhat low temperatures to create or remove  
indentations
in the plastic.  The device can read and write each position at a  
very high
rate, and since there are several thousand bits per position, with  
one bit
for each needle, the bandwidth is enormous.  (And it scales linearly  
with
the size of the device, too!)  Purportedly these grids can be easily  
built
with slight modifications to modern semiconductor etching  
technologies, and
the polymer plastic is reasonably simple to manufacture, so the  
resultant
cost per device is hundreds of times cheaper than today's drives.   
Likewise,
they have significantly higher memory density than current hardware  
due to
fewer relativistic and quantum effects (no magnetism).


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



