Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133014AbRDUXIE>; Sat, 21 Apr 2001 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133019AbRDUXHy>; Sat, 21 Apr 2001 19:07:54 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:51461 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S133014AbRDUXHe>;
	Sat, 21 Apr 2001 19:07:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Victor Julien <v.p.p.julien@let.rug.nl>
Organization: Huize Hofstee
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-pre3+ sound distortion
Date: Sun, 22 Apr 2001 01:05:44 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org> <01042121403000.00436@victor> <20010421225205.B2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010421225205.B2615@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Message-Id: <01042201054400.00463@victor>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done some further testing and i discoverd that the problem was 
introduced in 2.4.3-pre3. Pre1 en pre2 are fine. I've tried disabling the 
via-ide-driver, i386 instead of athlon as build architecture with no effect. 
I've tried disabling my network-card with no effect. Ik tried reproducing the 
problem in the console using setiathome and mpg123 and i was succesfull.

So, i guess the problem is in 2.4.3-pre3 and later. I'm not a coder so there 
is not much i can do i think. If you need any information please let me know.

Victor Julien



Please put my email adress in the CC when you reply.
