Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRGLOA3>; Thu, 12 Jul 2001 10:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbRGLOAT>; Thu, 12 Jul 2001 10:00:19 -0400
Received: from [62.58.73.254] ([62.58.73.254]:4338 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S264032AbRGLOAI>; Thu, 12 Jul 2001 10:00:08 -0400
Date: Thu, 12 Jul 2001 15:59:57 +0200 (MEST)
From: <ryan.sweet@atosorigin.com>
X-X-Sender: <rsweet@ats-dhcp-01.atos-group.nl>
To: <linux-kernel@vger.kernel.org>
Subject: follow-up: apic, and spontaneous reboots with smp diskless clients
 on 2.4.x (fwd)
Message-ID: <Pine.LNX.4.33.0107121557420.1665-100000@ats-dhcp-01.atos-group.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have just rebooted them all with "noapic" and am testing again, also
> collecting tcpdump output.

I was able to reproduce the problem with "noapic" on.  I am attempting to
cut my 800MB tcpdump file down to the relevant last couple of minutes.

