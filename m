Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274705AbRIYX6m>; Tue, 25 Sep 2001 19:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274738AbRIYX6c>; Tue, 25 Sep 2001 19:58:32 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:17799 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S274705AbRIYX6T>; Tue, 25 Sep 2001 19:58:19 -0400
Message-ID: <3BB11A30.CFED2454@bigfoot.com>
Date: Tue, 25 Sep 2001 16:58:40 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Newton <newton@unb.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FWD: RE: excessive interrupts on network cards
In-Reply-To: <3BB13A1B@webmail1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for grins what does 'procinfo -DSn2' say?

Chris Newton wrote:
> ...
> uptime:       0:07:54.17         context :    43253
> 
> irq  0:       500 timer                 irq 16:       131 eth2
> irq  1:         0 keyboard              irq 20:     22266 eth0
> irq  2:         0 cascade [4]           irq 21:         0 eth1
> irq  6:         0                       irq 30:         0 aic7xxx
> irq 12:         0                       irq 31:       121 aic7xxx
> irq 14:         0 ide0
--
