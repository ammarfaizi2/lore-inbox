Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291689AbSBNPOu>; Thu, 14 Feb 2002 10:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291702AbSBNPOa>; Thu, 14 Feb 2002 10:14:30 -0500
Received: from mark.staudinger.net ([207.252.75.224]:24326 "EHLO
	mark.staudinger.net") by vger.kernel.org with ESMTP
	id <S291689AbSBNPOT>; Thu, 14 Feb 2002 10:14:19 -0500
Date: Thu, 14 Feb 2002 10:26:41 -0500 (EST)
From: Mark Staudinger <mark@staudinger.net>
Message-Id: <200202141526.g1EFQfjC035904@mark.staudinger.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12 on Pentium?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU?  I'm
unable to get a 2.4.12 kernel to boot on a pentium class machine, regardless
of what I choose for the "Processor Family" support in the config.

A similar (if not identical) config of kernel 2.4.5 works just fine, even if
compiled for 686/Celeron processor family.

The machine reboots during the "loading kernel...." phase and before the 
"Uncompressing kernel" boot message.

Any ideas?

-Mark
