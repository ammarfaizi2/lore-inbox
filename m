Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRHGUzk>; Tue, 7 Aug 2001 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269435AbRHGUza>; Tue, 7 Aug 2001 16:55:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7041 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269434AbRHGUzP>; Tue, 7 Aug 2001 16:55:15 -0400
Date: Tue, 7 Aug 2001 16:55:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Igmar Palsenberg <maillist@jdimedia.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x VM problems thread
In-Reply-To: <Pine.LNX.4.33.0108072240300.3714-200000@jdi.jdimedia.nl>
Message-ID: <Pine.LNX.3.95.1010807165314.13578A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Igmar Palsenberg wrote:

> 
> Hi,
> 
> I've followed the 2.4.x VM thread stuff. Someone mentioned he will
> wite a test program. Attached program kills all boxen within 1 minute,
> it's not hard to see what it does.
> 
> I'm willing to test experimental stuff if needed.
> 
> 	Regards,

Wow a memory-mapped fork bomb! Now what on earth did you expect?
Run it from a user-account with ulimits enabled for slightly less
than the total system resources. Then complain.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


