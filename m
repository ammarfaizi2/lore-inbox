Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBLVtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBLVtT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVBLVtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:49:19 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:35658 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261202AbVBLVtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:49:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=WUQ9KfOdms9QtOZrlctm+0JMdNqyP9uGxNGCGpV1Iy/5+TAy/uo+L42SG6RxdyqxdKQBElg8VdzAbab4rOwtOpjKGTfp14FiZ5lOQJZPpPX/Di90+REaKu2juXpvmoHoaVRG+UGiFZ/s5DLJVHNEUBj6WMqQgqKotJ5/w2k+z3M=
Message-ID: <d14685de0502121349c2d5521@mail.gmail.com>
Date: Sat, 12 Feb 2005 22:49:15 +0100
From: sylvanino b <sylvanino@gmail.com>
Reply-To: sylvanino b <sylvanino@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to make a contribution
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing to get some advice and general information.

I wrote a kernel tool for my personnal usage which goal is to keep a
record of recent task preemptions and interruptions that appears under
linux. Although the record is short (a few minutes only), It can help
to analyse scheduling algorithm efficiency and also driver timing
issues. The user can access data from user-space, through proc
filesystem and analyze it with a graphics tool.  Then, since it's alsa
availlable within KDB, it can give clues and help for debugging.

So far, the tool is not a big deal, but not trivial either. When It is
running, the tool doesn't overload the system. And when it is not
running, it's just transparent.

I would like to share this tool if somebody is interested, but I dont
know how to proceed, I mean how to make a contribution an efficient
way. Any help/idea/information is welcome.
Thanks,

Sylvanino
