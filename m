Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292776AbSBUVZ3>; Thu, 21 Feb 2002 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292778AbSBUVZT>; Thu, 21 Feb 2002 16:25:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292776AbSBUVZJ>; Thu, 21 Feb 2002 16:25:09 -0500
Date: Thu, 21 Feb 2002 16:25:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Adam <ambx1@netscape.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs question
In-Reply-To: <3C755A8A.90000@netscape.net>
Message-ID: <Pine.LNX.3.95.1020221161906.254A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Adam wrote:
> 
> All devices will be arranged according to type.  There will be a folder 
                                                                   ^^^^^
> Method 2:
> Folders are created for each bus then devices are placed within them.
  ^^^^^^^

> member of a pci bus, it's folder will be within the pci folder.  The 
                            ^^^^^^                        ^^^^^^

What is this? Do you mean "directory" or "file", or even "inode"?

Or is this a troll from Microsoft?  We don't have such things in
real operating systems. Next thing you know, we'll need a "cabinet"
to keep the "folders" in.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

