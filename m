Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283303AbRK2QPA>; Thu, 29 Nov 2001 11:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283294AbRK2QOm>; Thu, 29 Nov 2001 11:14:42 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:40722 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S283292AbRK2QOW>;
	Thu, 29 Nov 2001 11:14:22 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15366.24278.890864.315442@abasin.nj.nec.com>
Date: Thu, 29 Nov 2001 11:14:14 -0500 (EST)
To: Nathan Poznick <poznick@conwaycorp.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
In-Reply-To: <20011129095107.A17457@conwaycorp.net>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com>
	<20011129095107.A17457@conwaycorp.net>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Poznick writes:
 > Thus spake Sven Heinicke:
 > > 
 > > The 2.4.16 kernel finally makes my clients happy with memory
 > > management.  The systems that froz up is a Dell of some sort or other
 > > with two 1Ghz Pentium IIIs and 4G of memory.  But, now I seems to be
 > > having ethernet problems.  With and eepro100 card:
 > 
 > I've encountered the same problem, with the same hardware setup (I
 > believe it's a Dell 2400, or something like that), on 2.4.14+xfs.  For
 > me it didn't lock up the entire machine however, it only seemed to
 > kill the network - I was able to reboot the machine cleanly once I got
 > to the console. (message from yesterday with the subject 'failed
 > assertion in tcp.c')  I too, am open to suggestions :-)
 > 

I suspect that I would of been able to reboot it if I was at work in
the middle of the night.  I am unable to try older kernels as until
2.4.16 I had memory issues.  The process that was doing so much eth0
is ran for like 3 days before the freeze.

   Sven
