Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293469AbSCFL06>; Wed, 6 Mar 2002 06:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293472AbSCFL0r>; Wed, 6 Mar 2002 06:26:47 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:56291 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293469AbSCFL0g>; Wed, 6 Mar 2002 06:26:36 -0500
Date: Wed, 6 Mar 2002 13:12:14 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: benh@kernel.crashing.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <3C85F872.7050306@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203061307310.2839-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Martin Dalecki wrote:

> 1. Indeed the code quality found there is *excellent* nothing comparable
>     with the messy crude found currently in linux.

I thought you stated that no one else was using something similar? Or 
were you refererring to the userland accessible ioctls? I believe 
FreeBSD-CURRENT might also have something in the works.

> 2. It convinced me that the current task-file interface in linux
>     is inadequate. So Alan please bear with me if your CF format
>     microdrive will have to not wakeup properly for some time...
>     The current mess will just have to go before something more
>     adequate can go in.

Before removing the current "mess", would it be too much to ask to provide 
a patches which remove and incorporate your proposed changes?


