Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSIES2G>; Thu, 5 Sep 2002 14:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSIES2G>; Thu, 5 Sep 2002 14:28:06 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:41198
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318009AbSIES2D>; Thu, 5 Sep 2002 14:28:03 -0400
Subject: Re: IO-APIC in SMP dual Athlon XP1800
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: scorpionlab@ieg.com.br
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209051453.54728.scorpionlab@ieg.com.br>
References: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz> 
	<200209051453.54728.scorpionlab@ieg.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 19:33:30 +0100
Message-Id: <1031250810.7367.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 18:53, Scorpion wrote:
> Hi All,
> I got my Dual Athlon XP1800 working now. 
> Everything gonna well after changed MP 1.4 Support to disable in BIOS, and 
> leaving MP table enabled.
> Anyone knows if linux 2.4.19 has not yet a full implemantation of MP 1.4 or if 
> it is just a BIOSes bug?

On the 1004 BIOS with the ASUS it seems to be a bios table error. Later
BIOSes fixed it, then removed the option, then broke lots of other
stuff. I went back to 1004 so I dont know how the newest fare

