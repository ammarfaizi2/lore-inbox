Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUGLX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUGLX7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUGLX7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:59:03 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:36270 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264346AbUGLX7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:59:01 -0400
Message-Id: <200407122358.i6CNwvBD003469@localhost.localdomain>
To: Andrew Morton <akpm@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, linux-audio-dev@music.columbia.edu,
       mingo@elte.hu, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch 
In-reply-to: Your message of "Mon, 12 Jul 2004 16:31:41 PDT."
             <20040712163141.31ef1ad6.akpm@osdl.org> 
Date: Mon, 12 Jul 2004 19:58:57 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.151.61.237] at Mon, 12 Jul 2004 18:59:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
>fixes ended up breaking the fs in subtle ways and I eventually gave up.

andrew, this is really helpful. should we conclude that until some
announcement from reiser that they have addressed this, the reiserfs
should be avoided on low latency systems?

--p
