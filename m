Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbREOWfs>; Tue, 15 May 2001 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbREOWfi>; Tue, 15 May 2001 18:35:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261663AbREOWfX>; Tue, 15 May 2001 18:35:23 -0400
Message-ID: <3B01AEF6.C309864F@transmeta.com>
Date: Tue, 15 May 2001 15:34:30 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chip Salzenberg <chip@valinux.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14znJI-0003EY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 1. is of course a problem in itself.  Someone who creates overlapping
> > ioctls should be spanked, hard.
> 
> No argument there. But there is no LANANA ioctl body
> 

I though Michael Chastain was maintaining this set.  No, we haven't made
it an official LANANA function, mostly because I didn't want to push.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
