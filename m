Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRF1TH4>; Thu, 28 Jun 2001 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbRF1THg>; Thu, 28 Jun 2001 15:07:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63503 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263894AbRF1THb>; Thu, 28 Jun 2001 15:07:31 -0400
Subject: Re: BIG PROBLEM
To: difda@hotmail.com (james bond)
Date: Thu, 28 Jun 2001 20:07:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <LAW2-F118HsRsWg8ubZ000077c1@hotmail.com> from "james bond" at Jun 28, 2001 06:49:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fh8J-0007Sz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've  compiled the kernel 2.4.4 , once i finish and boot the first time on 
> 2.4.4 everything goses ok ,
> only too problemes
> 1st-  klogd takes 100%  CPU time

Old old versions of klogd had bugs where they would do that. If there is
a continuous problem it may also do so - does 'dmesg' show anything ?

> 2nd- cat /proc/cpuinf --guives me too CPU'S  without putin any info about 
> the CPU 1

Im not sure I follow the description - can you explain more.

