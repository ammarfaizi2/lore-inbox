Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSH0HZF>; Tue, 27 Aug 2002 03:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSH0HZF>; Tue, 27 Aug 2002 03:25:05 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:44731 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315267AbSH0HZF>; Tue, 27 Aug 2002 03:25:05 -0400
Date: Tue, 27 Aug 2002 09:46:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <200208261823.55005.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208270943520.11104-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, James Cleverdon wrote:

> I'm not allowed to report second hand rumors from the folks who assisted with 
> the debug of the x440 HAL, so I won't mention that they may or may not be 
> using clustered logical interrupts and adjusting priority with the TPR.

Thanks anyway =)

> I can admit that I have no clue how they assign IRQs to APIC clusters, whether 
> randomly or if they try some load balancing scheme.

	Zwane
-- 
function.linuxpower.ca

