Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAZNx3>; Fri, 26 Jan 2001 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAZNxW>; Fri, 26 Jan 2001 08:53:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129561AbRAZNwu>; Fri, 26 Jan 2001 08:52:50 -0500
Date: Fri, 26 Jan 2001 08:49:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob Kaper <cap@capsi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
In-Reply-To: <20010126141350.Q6979@capsi.com>
Message-ID: <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Rob Kaper wrote:

> If this is ext2 specific, just say so and I'll find a better list to discuss
> this: (any good ext2 lists available for example?)
> 
> Is there a way to rename lost+found ?? It bothers me to see it in ls all the
> time because 99.9% of my time it's just useless and I really think
> .lost+found (a hidden file) would make much more sense for daily use. I
> assume this would require some ext2 changes as well as a patch to e2fsck
> etc. (with backwards compatibility of course)

Get used to it. This is part of the Linux/Unix heritage!  A file-system
without a lost+found directory is like love without sex.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
