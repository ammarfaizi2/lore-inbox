Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTAOTGG>; Wed, 15 Jan 2003 14:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbTAOTGG>; Wed, 15 Jan 2003 14:06:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13447 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266969AbTAOTGE>; Wed, 15 Jan 2003 14:06:04 -0500
Date: Wed, 15 Jan 2003 11:14:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 0/5 Fix Summit support
Message-ID: <7660000.1042658097@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sequence makes Summit finally work properly - most of the code
was originally written by James Cleverdon, and it has been split up
and cleaned up by John Stultz and I.

I've tested these on UP, standard SMP, NUMA-Q and Summit, and have
test-compiled them for UP+IO-APIC as well. They should change nothing
at all for standard machines.

Please apply, thanks,

Martin.

