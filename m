Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317310AbSFGR6f>; Fri, 7 Jun 2002 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317311AbSFGR6e>; Fri, 7 Jun 2002 13:58:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7151 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317310AbSFGR6e>; Fri, 7 Jun 2002 13:58:34 -0400
Subject: Re: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Bonin <kernel@bonin.ca>
Cc: Chris Fuller <cfuller@broadjump.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D00F107.8070402@bonin.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 19:52:13 +0100
Message-Id: <1023475933.25522.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-07 at 18:44, Andre Bonin wrote:
> Creative Labs warns that it's sblive series of cards aren't compatible 
> with SMP systems.  Though i've had the S2460 motherboard and the only 
> trouble i have had was that EAX didn't work properly.  A friend of mine 
> has an sblive with a dual celeron and he also has had this problem of 
> deadlocks with the SBLive.  The audigy however is fully compatible.

On Linux at least I've never had a problem with the SB Live since the
SMP bugs in earlier 2.4 trees got fixed (and they were kernel bugs). I
can well believe the SB emulation magic doesn't work with old games in
SMP mode but we don't drive it in any emulation mode nor need to

