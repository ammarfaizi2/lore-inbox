Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132941AbRDJHNg>; Tue, 10 Apr 2001 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132944AbRDJHN1>; Tue, 10 Apr 2001 03:13:27 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:54797 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S132941AbRDJHNQ>; Tue, 10 Apr 2001 03:13:16 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2001 09:12:57 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: announce: PPSkit patch for Linux 2.4.2 (pre6)
Message-ID: <3AD2CE98.28151.46E93A@localhost>
In-Reply-To: <Pine.LNX.4.21.0104091815160.1367-300000@terran.bussi.de>
In-Reply-To: <3AC83FF1.27420.398B86@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Cycle Counters,

Linux currently tries to synchronize TSCs for consistent time in SMP 
systems. One would not believe what combinations of hardware are tried, 
especially for precision timing. Here's a short answer to my asking-
back about a complaint (the kernel is reporting negative time warps).

As any problem, it can be solved with some overhead, but should it be 
done?

Replies to me too, as I'm not subscribed, please.

Ulrich

On 9 Apr 2001, at 18:39, Andreas Bussjaeger wrote:

> > from the current CPU. All these values seem highly suspect. However a 
> > few more values would be helpful to diagnose the situation.
> 
> I have to tell you that I have one 533 MHz Celeron and one 433 MHz
> Celeron.
> 
> > indicate that the CPUs are 968ms apart (each CPU half from the average).


