Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbTCNSmj>; Fri, 14 Mar 2003 13:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbTCNSmj>; Fri, 14 Mar 2003 13:42:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263416AbTCNSmi>; Fri, 14 Mar 2003 13:42:38 -0500
Date: Fri, 14 Mar 2003 13:56:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Olaf Titz <olaf@bigred.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <E18ttUx-00036U-00@bigred.inka.de>
Message-ID: <Pine.LNX.3.95.1030314135149.5981A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Olaf Titz wrote:

> > code is designed to be easily decoded forward, noone executes code going
> > backwards. Finding out what starts at EIP is easy.
> 
> I remember reading once in a magazine that there exists an
> undocumented/illegal instruction in the x86 which causes the IP to run
> backwards, similar to setting the D flag.
> 
> Was an April 1st issue though ;-)
> 
> Olaf

There was a whole operating system written upon this principle.
I think it was called "retrograde", erm, "Redmond", yes, that's
what it was, something out of Redmond, Washington, ASU ^M^M^M USA


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


