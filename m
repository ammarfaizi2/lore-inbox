Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319163AbSH2KFq>; Thu, 29 Aug 2002 06:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSH2KFq>; Thu, 29 Aug 2002 06:05:46 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:1962 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319163AbSH2KFp>; Thu, 29 Aug 2002 06:05:45 -0400
Date: Thu, 29 Aug 2002 12:26:56 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828133240.A766@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0208291225050.13929-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Cort Dougan wrote:

> My frustration comes from the fact that my CPU time is being stolen from me
> because of bad mechanical and software design.  I'm not even notified of
> it.  If there were some way for the OS to over-ride or even be notified of
> these events I'd have less of a problem with it.  As it is now, poor
> system design is affecting OS design more and more.

The P4 processor does send a notification (interrupt), there is support 
for this interrupt in newer kernels. I'm not sure about other processors.

	Zwane

-- 
function.linuxpower.ca


