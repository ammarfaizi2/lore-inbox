Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbVCDUpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbVCDUpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVCDUl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:41:58 -0500
Received: from CYRUS.andrew.cmu.edu ([128.2.10.173]:32718 "EHLO
	mail-fe3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S263003AbVCDUha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:37:30 -0500
Message-ID: <4228C6FD.5000409@andrew.cmu.edu>
Date: Fri, 04 Mar 2005 15:37:17 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>	<42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org>	<42240EB3.6040504@andrew.cmu.edu> <87is4b21s5.fsf@bytesex.org>
In-Reply-To: <87is4b21s5.fsf@bytesex.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a final update, I added the third card to another machine and that 
doesn't work either.  So after trying 3 kernels on two machines with 
either one or two cards, and trying the ~120 different card options for 
bttv to no avail, I'll just guess this card isn't actually supported 
right now.

The strange thing is that it ever worked in the first place, and 
amazingly that it worked the first time I tried it with no extra effort, 
yet never again after a reboot, nor on any other machines.

I'll take this discussion to the video for linux mailing list and try to 
find out how to add support for this card.  Once it works, I'll see if 
my test program can still lock up the machine from userspace; If so 
that'll be a separate issue to debug.  Thanks for the help.

   Jim Bruce
