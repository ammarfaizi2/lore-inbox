Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136135AbREGOhi>; Mon, 7 May 2001 10:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136136AbREGOh2>; Mon, 7 May 2001 10:37:28 -0400
Received: from css-1.cs.iastate.edu ([129.186.3.24]:8197 "EHLO
	css-1.cs.iastate.edu") by vger.kernel.org with ESMTP
	id <S136135AbREGOhM>; Mon, 7 May 2001 10:37:12 -0400
Date: Mon, 7 May 2001 09:37:09 -0500 (CDT)
From: "C.Praveen" <cpraveen@cs.iastate.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Crash
Message-ID: <Pine.HPX.4.31.0105070927560.4184-100000@beast.cs.iastate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is it possible to screw up the hardware entirely from software? I made
some changes to the 2.4.2 kernel to support save/restore of the event
counters. It crashed and does not come up at all, what i would like to
know is if there is any way to screw the board from software in such a way
that power off and power on does not bring it up ?.

Its a dual pentium-3 machine. The power supply is gone also, the power
supply from the crashed machine does not bring up another normal computer,
also power supply from normal computer does not bring up crashed computer.
so there must be something really wrong with the motherboard. Id like to
know if it was because of me ..., is it possible to do things to the
motherboard from software (I did change things in the kernel, timer ISR
also), that wont boot the machine at all when power turned off and then on
?. from aboce is it very likely that the power supply went out and took
the board with it ??

and by "doesnt come up" i meant, totally blank, no output at all
absolutely

*Any* help/comments please!

Praveen C


