Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAaEhv>; Tue, 30 Jan 2001 23:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAaEhl>; Tue, 30 Jan 2001 23:37:41 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:3140 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129729AbRAaEhY>; Tue, 30 Jan 2001 23:37:24 -0500
Message-ID: <3A77966E.444B1160@linux.com>
Date: Tue, 30 Jan 2001 20:37:02 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mhm.  Is it worth the effort to make a dependancy on the CPU type for SMP?

</idle questions>

-d

Stephen Frost wrote:

> * David Ford (david@linux.com) wrote:
> > A person just brought up a problem in #kernelnewbies, building an SMP
> > kernel doesn't work very well, current is undefined.  I don't have more
> > time to debug it but I'll strip the config and put it up at
> > http://stuph.org/smp-config
>
>         They're trying to compile SMP for Athlon/K7 (CONFIG_MK7=y).

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
