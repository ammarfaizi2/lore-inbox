Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRGESol>; Thu, 5 Jul 2001 14:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266221AbRGESob>; Thu, 5 Jul 2001 14:44:31 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:6422 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S266220AbRGESoM>; Thu, 5 Jul 2001 14:44:12 -0400
Message-ID: <3B44B569.85BCFA0E@pp.htv.fi>
Date: Thu, 05 Jul 2001 21:43:53 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Guyett <justin@soze.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.[56] kernel + xfree 4.1.0
In-Reply-To: <Pine.LNX.4.33.0107041930090.32139-100000@gw.soze.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett wrote:
> 
> After upgrading to xfree 4.1.0, after switching back to the console after
> starting X, suspending, and resuming, the text-mode terminals are corrupt

2.4.x and XFree86 4.1.0 is first combination that doesn't mess up my text
console and crash if there are graphics updates in X when console is in text
mode. XF 3.3.6 was just deadlocking my machine (I used Accelerated-X before
XFree86 4.x). I haven't tested the framebuffer in this machine.

GDA is Voodoo3 2000 PCI (SDRAM).

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
