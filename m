Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGTBPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGTBPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUGTBPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 21:15:45 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:12725 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S265086AbUGTBPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 21:15:43 -0400
In-Reply-To: <000001c46615$b4608fb0$0302a8c0@vaio>
References: <000001c46615$b4608fb0$0302a8c0@vaio>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4C1DEB9D-D9EA-11D8-9612-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Belkin Bluetooth Access Point GPL violation
Date: Mon, 19 Jul 2004 21:15:33 -0400
To: Robert Lowery <rlowery@optusnet.com.au>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09, 2004, at 20:34, Robert Lowery wrote:
> Would any one on the list be interested in taking this further?

I managed to obtain some sources, I can't tell immediately how complete
they are, but they do seem to incorporate some BlueTooth stuff.  A 
tarball
is available at http://www.rovingnetworks.com/accesspoint.tgz  Thanks to
Mike Conrad at RovingNetworks for providing the sources without much
hassle!

I believe that all of these are under GPL, but please confirm before you
assume so by looking through the sources yourself.

NOTE: Mike said that it is _very_ easy to completely bork your wireless
access point if you try to upgrade its kernel.  It _doesn't_ have a 
flash
ROM that can be removed for reprogramming, so BE CAREFUL.  I am
personally most interested in their BlueTooth stack and other non-2.0
stuff.  It might be useless to us, but there's probably somebody that
would find it handy.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


