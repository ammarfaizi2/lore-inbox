Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTBVRIm>; Sat, 22 Feb 2003 12:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTBVRIl>; Sat, 22 Feb 2003 12:08:41 -0500
Received: from angband.namesys.com ([212.16.7.85]:40832 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267106AbTBVRIl>; Sat, 22 Feb 2003 12:08:41 -0500
Date: Sat, 22 Feb 2003 20:18:45 +0300
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: thetech@folkwolf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Box freezes if I enable "AMD 76x native power management"
Message-ID: <20030222201845.A2865@namesys.com>
References: <20030222163057.A884@namesys.com> <1045935866.4723.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045935866.4723.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 22, 2003 at 05:44:27PM +0000, Alan Cox wrote:
> >    Starting from 2.4.20 until now (including 2.4.21-pre4 and 2.4.21-pre4-ac5",
> >    whenever I enable "AMD 76x native power management" in my kernel config, I get
> >    kernel that hangs at boot after reporting elevator stuff about my IDE drives.
> >    Is anybody interested?
> It doesnt work with some tyan boards. I've never found out why. Most of them you
> load the module, it stops, you poke the button and it wakes up again and then works

This is not my case it seems. No matter what I press, it is dead.
But I compile it statically into kernel, though. Have not tried with a
module yet, though.

Bye,
    Oleg
