Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277244AbRJIOT0>; Tue, 9 Oct 2001 10:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277241AbRJIOTQ>; Tue, 9 Oct 2001 10:19:16 -0400
Received: from quark.didntduck.org ([216.43.55.190]:25362 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S277244AbRJIOTK>; Tue, 9 Oct 2001 10:19:10 -0400
Message-ID: <3BC30755.30F47321@didntduck.org>
Date: Tue, 09 Oct 2001 10:19:01 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alejandro Conty <zz01f074@etsiig.uniovi.es>
CC: Gergely Tamas <dice@mfa.kfki.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <LAW2-OE29ilTmbtQVi0000079ef@hotmail.com>
		<Pine.LNX.4.33.0110091347001.12835-100000@falka.mfa.kfki.hu> <20011009155907.6c9e0b98.zz01f074@etsiig.uniovi.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Conty wrote:
> 
> Could my random kernel oopses be caused by that bug?
> 
> I have a VIA (ASUS A7V) cipset an K7 1000Mhz, and sometimes the kernel crash.
> I just updated to kernel 2.4.10, and the first problem is that I get a random
> oops if I try to load analog.o with modprobe. I sent a report of this problem
> two days ago.
> 
> Could that patch solve my problem?

The oops with the analog joystick driver is fixed in 2.4.11-preX.

--

				Brian Gerst
