Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277927AbRJITdE>; Tue, 9 Oct 2001 15:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277928AbRJITcy>; Tue, 9 Oct 2001 15:32:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277927AbRJITco>; Tue, 9 Oct 2001 15:32:44 -0400
Date: Tue, 9 Oct 2001 15:30:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Chris Siebenmann <cks@utcc.utoronto.ca>, linux-kernel@vger.kernel.org
Subject: Re: Breaking system configuration in stable kernels
In-Reply-To: <Pine.LNX.3.96.1011009144430.31112A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1011009151209.3636A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Bill Davidsen wrote:

> On Mon, 8 Oct 2001, Chris Siebenmann wrote:
> 
> > You write:
> > |   I've beaten this dead horse before, but Linux will not look to
> > | management like a viable candidate for default o/s until whoever releases

Then educate "management". Have them use another Operating System.
Try Microsoft Windows-2000/Professional. I've got it on my lap-top.
It has never crashed so it's pretty good by Microsoft standards.
However, I just finished downloading the latest Linux-kernel by
using FTP on that machine. I didn't want to tie up this machine.
I started the download at about 11:00 this morning. It finished
around 3:00 this afternoon. We have a 1.3 GHz fiber link and the LAN
is 100 MB/s. Pretty good for something that usually takes 5 minutes
on Linux.

As I see it, you get the chance to complain about some poor performance
because you don't have anything to compare present performance against.
So, you upgrade to a minimally-tested kernel and complain that it's
not a "viable candidate for default o/s..." -your words. Guess what,
this complaint will always fall upon deaf ears.

What will help get your bleeding-edge kernel stable, is a bug report,
a performance report, and sometimes even a "Hey... This one works great!".

Don't ever expect the kernel's internals to remain constant. This means
that you will have to modify any of your custom modules for each and
every kernel you download.

You can expect the API to remain constant. If it doesn't you have
a valid beef. Otherwise, you will be talking to the forest. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


