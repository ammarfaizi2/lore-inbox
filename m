Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSDYMah>; Thu, 25 Apr 2002 08:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSDYMag>; Thu, 25 Apr 2002 08:30:36 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:23049 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312294AbSDYMag>; Thu, 25 Apr 2002 08:30:36 -0400
Date: Thu, 25 Apr 2002 13:38:00 +0100
From: Ian Molton <spyro@armlinux.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-Id: <20020425133800.6a549ed7.spyro@armlinux.org>
In-Reply-To: <20020424235538.A1606@zalem.puupuu.org>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert Awoke this dragon, who will now respond:

>  > I shouldnt. its a pointless waste of bandwidth.
>  > 
>  > Now, whats YOUR answer?
> 
>  Developpers need complete sources.  No questions about that.  If they
>  don't have the complete sources, they'll fuck things up.  So the
>  developpers have zero use for partial downloadings.

Sorry, that doesnt fly. If I dont work on SCSI, only on networking, I
/dont/ need the SCSI code. Even if I had it, I wouldnt read it.

I deleted all the arch directories except ARM and X86 on my machine to
speed up grepping the kernel.

so, not having all the source can speed thigs up.

>  Some users may like to be able to download only the core code and
>  drivers/filesystems/architectures they use.

This developer would too.

>  Ignoring the obvious
>  version drift problems that will happen,

Why would they happen?

> proposing such a service
>  requires work and a large amount of bandwidth.  Do you volunteer?

Surely it requires LESS bandwidth than if people are sucking the WHOLE
kernel ?
