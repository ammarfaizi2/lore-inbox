Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbSLaCL7>; Mon, 30 Dec 2002 21:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLaCL7>; Mon, 30 Dec 2002 21:11:59 -0500
Received: from pandora.cantech.net.au ([203.26.6.29]:3079 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S267121AbSLaCL7>; Mon, 30 Dec 2002 21:11:59 -0500
Date: Tue, 31 Dec 2002 10:20:13 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Indention - why spaces?
In-Reply-To: <3E109EF1.5040901@WirelessNetworksInc.com>
Message-ID: <Pine.LNX.4.44.0212311004160.1039-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Herman Oosthuysen wrote:

> This problem is as old as the typewriter itself.  The trouble is that a 
> Tab character doesn't have a fixed size - some set it to 3 characters 
> wide, some to 4 some to 8, or whatever.
> 
> The 'indent' program was written a couple of decades ago, to pretty 
> print C code.  It has a 'GNU' standard, but I'm not aware of a 'Linux' 
> standard.  Anyhoo, the only way to prevent indentation wars is to use 
> spaces, not tabs and to set 'diff' to ignore white space when comparing 
> files...

indent itself dosen't have a 'Linux standard' BUT .../linux/scripts/Lindent
is there to get things right (in terms of CodingStyle)

I don't know if is usinging it or even if it is still current but it's a
starting point.

Yours Tony

   Jan 22-25 2003           Linux.Conf.AU            http://linux.conf.au/
		  The Australian Linux Technical Conference!

