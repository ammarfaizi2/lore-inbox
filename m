Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSBMWCw>; Wed, 13 Feb 2002 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSBMWCb>; Wed, 13 Feb 2002 17:02:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58757 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288996AbSBMWCY>; Wed, 13 Feb 2002 17:02:24 -0500
Date: Wed, 13 Feb 2002 17:02:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <Pine.LNX.3.96.1020213163646.12448B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1020213165845.22523A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Bill Davidsen wrote:

> On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> 
> > The advantage, of course is that if you are executing the kernel,
> > it can give you all the information necessary to recreate a
> > new one from the sources because its .config is embeded into
> > itself. Once you have the ".config" file, you just do `make oldconfig`
> > and you are home free.
> 
> But it does no such thing! You not only need the config file, you need the
> source. So you now need to add to the kernel the entire source tree from
> which it was built, or perhaps just a diff file from a kernel.org source,
> which you will suitably compress, of course.

What the F..? You are outa your mind. The PURPOSE is to create a .config
from which one can do a `make oldconfig` and get the same drivers,
modules, etc., that you have in the running kernel.

Of course you need a kernel source-code tree.

[SNIPPED rest of g...]

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


