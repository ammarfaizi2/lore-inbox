Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSFRVV5>; Tue, 18 Jun 2002 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSFRVV4>; Tue, 18 Jun 2002 17:21:56 -0400
Received: from ajax.rutgers.edu ([128.6.10.9]:36092 "EHLO ajax.rutgers.edu")
	by vger.kernel.org with ESMTP id <S317627AbSFRVVz>;
	Tue, 18 Jun 2002 17:21:55 -0400
Date: Tue, 18 Jun 2002 17:21:49 -0400 (EDT)
From: zaimi@pegasus.rutgers.edu
To: linux-kernel@vger.kernel.org
Subject: kernel upgrade on the fly
Message-ID: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

 has anybody worked or thought about a property to upgrade the kernel
while the system is running?  ie. with all processes waiting in their
queues while the resident-older kernel gets replaced by a newer one.

I can see the advantage of such a thing when a server can have the kernel
upgraded (major or minor upgrade) without disrupting the ongoing services
(ok, maybe a small few-seconds delay). Another instance would be to
switch between different kernels in the /boot/ directory (for testing
purposes, etc.) without rebooting the machine.

A search of the web resulted in no related information to the above so I
dont know if such an issue has been raised before.

Would anybody else think this to be an interesting property to have for
the linux kernel or care to comment on this idea?

Cheers,

Adi Zaimi
Rutgers University

