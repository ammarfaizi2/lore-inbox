Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbQJaUtt>; Tue, 31 Oct 2000 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbQJaUtk>; Tue, 31 Oct 2000 15:49:40 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:47932 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130499AbQJaUt0>; Tue, 31 Oct 2000 15:49:26 -0500
Date: Tue, 31 Oct 2000 14:48:53 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200010312048.OAA244641@tomcat.admin.navo.hpc.mil>
To: alan@lxorguk.ukuu.org.uk, baettig@scs.ch (Reto Baettig)
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qi9t-0008E9-00@the-village.bc.nu>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jmerkey@timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> > And what if I'd like to use the network for something different than
> > html?
> 
> Read the tux source. Then come back and ask sensible questions

Also pay attention to the security aspects of a true "zero copy" TCP stack.
It means that SOMETIMES a user buffer will recieve data that is destined
for a different process.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
