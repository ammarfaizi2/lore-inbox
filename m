Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310298AbSCGMd2>; Thu, 7 Mar 2002 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310299AbSCGMdS>; Thu, 7 Mar 2002 07:33:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310298AbSCGMdC>; Thu, 7 Mar 2002 07:33:02 -0500
Subject: Re: [PATCH] Rework of /proc/stat
To: jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet)
Date: Thu, 7 Mar 2002 12:48:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C874AE8.9060208@linkvest.com> from "Jean-Eric Cuendet" at Mar 07, 2002 12:11:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ixJo-00024Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What does the sard patches?

They collect I/O data

> What I need is to be able to get IO stats to pass them (through a home 
> made script) to SNMP which have no IO stats available.
> Is it possible to get SARD values through /proc ? Or at least in a 
> simple shell script?

Yes - it puts it in /proc/partitions
