Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVLZSJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVLZSJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVLZSJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:09:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50561 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932078AbVLZSJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:09:43 -0500
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 13:14:52 -0500
Message-Id: <1135620892.8293.60.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 10:02 -0800, Mark Knecht wrote:
> Hi Linus,
>    I've visiting at my parents house and gave 2.6.15-rc7 a try on my
> dad's machine. This machine is his normal desktop box which I
> administer remotely, as well as a MythTV server. The new kernel built
> and booted fine. I then built the NVidia stuff. However when I tried
> to build the ivtv driver from portage it failed:

There's nothing the kernel developers can do about regressions in out of
tree modules - there is no stable kernel module API so the authors of
that module will have to fix it.

Any idea why the IVTV module has not been submitted for mainline?

Lee

