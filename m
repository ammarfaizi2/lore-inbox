Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTJCKEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTJCKEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:04:38 -0400
Received: from bvds.geneva.edu ([63.172.29.191]:49117 "EHLO bvds.geneva.edu")
	by vger.kernel.org with ESMTP id S263676AbTJCKEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:04:38 -0400
From: <bvds@bvds.geneva.edu>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
In-reply-to: <p73y8w2yboa.fsf@oldwotan.suse.de> (message from Andi Kleen on 03
	Oct 2003 10:20:53 +0200)
Subject: Re: segfault error on x86_64
References: <20031002215345.A1D33E24D6@bvds.geneva.edu.suse.lists.linux.kernel> <p73y8w2yboa.fsf@oldwotan.suse.de>
Message-Id: <20031003100434.105F0E24D6@bvds.geneva.edu>
Date: Fri,  3 Oct 2003 06:04:34 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sep 30 23:45:00 gideon kernel: bumps[12960]: segfault at 0000002a95611000 rip 0000000000402150 rsp 0000007fbffff1a8 error 6
>
>Some random program on your system. The x86-64 kernel logs all unhandled
>segfaults by default. It is unlikely to be a kernel problem.
>
>-Andi

So it doesn't have to be a kernel module of some kind?  
I have lm_sensors and comedi (data acquisition stuff) running,
which have modules inserted into the kernel.

BvdS
