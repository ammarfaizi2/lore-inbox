Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVHIMMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVHIMMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 08:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHIMMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 08:12:12 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:7072 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932514AbVHIMMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 08:12:12 -0400
Message-ID: <42F89F79.1060103@aitel.hist.no>
Date: Tue, 09 Aug 2005 14:20:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>	 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
In-Reply-To: <21d7e99705080503515e3045d5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>
>     I switched back to 2.6.13-rc4-mm1 at this point for another reason,
>     my X display aquired a nasty tendency to go blank for no reason
>     during work,
>     something I could fix by changing resolution baqck and forth.  X
>     also tended to get
>     stuck for a minute now and then - a problem I haven't seen since
>     early 2.6.
>
>
>
> which head the radeon or MGA or both?

The radeon 9200SE-pci gets stuck.  The MGA-agp seems to be fine. I have 
compiled
dri support for both, but I can't use it at the moment.  I think that is
caused by having ubuntu's xorg installed on debian.  I needed xorg
in order to run an xserver that doesn't use any tty - this way I can use
two keyboards and have two simultaneous users. Debians xorg wasn't ready
at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no problems 
there.

Helge Hafting
