Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284587AbRLIWqR>; Sun, 9 Dec 2001 17:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284584AbRLIWqJ>; Sun, 9 Dec 2001 17:46:09 -0500
Received: from [63.204.6.12] ([63.204.6.12]:19436 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S284580AbRLIWpt>;
	Sun, 9 Dec 2001 17:45:49 -0500
Date: Sun, 9 Dec 2001 17:45:23 -0500 (EST)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: <marcelo@conectiva.com.br>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Power Management support for opl3sa2
In-Reply-To: <Pine.LNX.4.33.0112091427410.17944-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112091737230.30328-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Zwane Mwaikambo wrote:

> Enables the power management features of the opl3sa2 and according to the
> databooks it should work for all the chipsets supported by opl3sa2. I've
> tested it on a YMF715 with positive results.
>
> I can't push this to the driver maintainer first and then from there to
> Linus and Marcelo because the maintainer isn't responding to mail.

AFAICS, today is the first time you've emailed me directly to ask about
it.  I don't have a way to test the functionality this patch adds and
can't recall seeing anyone other than yourself report on it.  However,
it looks pretty harmless, please apply Marcelo & Linus.

Scott

PS: Zwane, feel like taking over as maintainer of this driver?


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


