Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310789AbSCPVqO>; Sat, 16 Mar 2002 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310721AbSCPVqE>; Sat, 16 Mar 2002 16:46:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310776AbSCPVpw>; Sat, 16 Mar 2002 16:45:52 -0500
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
To: yodaiken@fsmlabs.com
Date: Sat, 16 Mar 2002 22:00:07 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), ak@suse.de (Andi Kleen),
        paulus@samba.org (Paul Mackerras), linux-kernel@vger.kernel.org
In-Reply-To: <20020316143916.A23204@hq.fsmlabs.com> from "yodaiken@fsmlabs.com" at Mar 16, 2002 02:39:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mMDf-0007JE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> databases, routing tables, and images. Our good friends at Intel
> claim "carrier grade" Linux  needs to run threaded apps
> with 10,000 threads to depose Solaris in telecom - all sharing the
> same monster address space.=20

Thats intel though. The same people who seem to think that hyperthreading
in the CPU is required for carrier grade work 8)
