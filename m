Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRBNTi5>; Wed, 14 Feb 2001 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRBNTih>; Wed, 14 Feb 2001 14:38:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131135AbRBNTiG>; Wed, 14 Feb 2001 14:38:06 -0500
Subject: Re: longjmp problem
To: labruna@cli.di.unipi.it (Elena Labruna)
Date: Wed, 14 Feb 2001 19:38:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102120802270.3423-100000@delta19.cli.di.unipi.it> from "Elena Labruna" at Feb 12, 2001 08:10:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T7kj-0005ne-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm working with a C package written by other
> on a linux machine with kernel version 2.2.14,
> often in a calls of longjmp routine
> the system crash with a SIGSEGV signal. 
>  
> Anyone can tell me if it can be a kernel problem ?

Unlikely. If it was kernel related you would see an Oops. 



