Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSIJRTg>; Tue, 10 Sep 2002 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSIJRTg>; Tue, 10 Sep 2002 13:19:36 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:33432 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317816AbSIJRTe>; Tue, 10 Sep 2002 13:19:34 -0400
Date: Tue, 10 Sep 2002 19:47:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.10.10209091343540.16589-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0209101945410.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Andre Hedrick wrote:

> You may not switch this in the middle of the execution of a command block.
> If you want to try this, go for it, and leave me off the CC for the mess
> you will make of your data.

No worries, it was mentioned as an auxiliary comment on another topic, i 
definitely do _not_ want to go anywhere near IDE code last i saw it has 
quite a head count ;)

	Zwane
-- 
function.linuxpower.ca

