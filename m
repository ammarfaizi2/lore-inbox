Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbSJDIlv>; Fri, 4 Oct 2002 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbSJDIlv>; Fri, 4 Oct 2002 04:41:51 -0400
Received: from 62-190-201-42.pdu.pipex.net ([62.190.201.42]:63749 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261535AbSJDIlu>; Fri, 4 Oct 2002 04:41:50 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210040855.g948tuJo001326@darkstar.example.net>
Subject: Re: 2.5.40 - menuconfig crash
To: linux.wali@gmx.de (Michael Wahlbrink)
Date: Fri, 4 Oct 2002 09:55:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210041041.50955.linux.wali@gmx.de> from "Michael Wahlbrink" at Oct 04, 2002 10:41:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> after the call of linus for giving the 2.5.40 a test I decided to make my 
> first experiences with the new kernel series.
> But I was'nt very lucky, the make menuconfig breaks when I try to enter the 
> following entry:
> sound -> Advanced Linux Sound Architecture -> 'crash'
> The relevant part of the error is:
> Q> ./scripts/Menuconfig: MCmenu74: command not found
> I've no special hardware here and if you need more informations please ask ;-)
> any hints how I can get the alsa stuff into the kernel?

I'm pretty sure there have been various patches to address this floating around the mailing list - have a look back in the archives for the last few days, and you should be able to find them.

> ps: I hope it's all correct with this post, its my first mail to lkml...

No problem.

John.
