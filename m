Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbSKSUQN>; Tue, 19 Nov 2002 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSKSUQN>; Tue, 19 Nov 2002 15:16:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14468 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267138AbSKSUQM>; Tue, 19 Nov 2002 15:16:12 -0500
Date: Tue, 19 Nov 2002 15:22:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
In-Reply-To: <20021119201110.GA11192@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Sam Ravnborg wrote:

> Based on some initial work by Kai Germaschewski I have made a
> working prototype of separate obj/src tree.
> 
> Usage example:
> #src located in ~/bk/linux-2.5.sepobj
> mkdir ~/compile/v2.5
> cd ~/compile/v2.5
> sh ../../kb/v2.5/kbuild

[SNIPPED...]

I have a question; "What problem is this supposed to solve?"
This looks like a M$ism to me. Real source trees don't
look like this. If you don't have write access to the source-
code tree, you are screwed on a real project anyway. That's
why we have CVS, tar and other tools to provide a local copy.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


