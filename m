Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbRFASYP>; Fri, 1 Jun 2001 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFASX4>; Fri, 1 Jun 2001 14:23:56 -0400
Received: from pille1.addcom.de ([62.96.128.35]:4618 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S263311AbRFASXn>;
	Fri, 1 Jun 2001 14:23:43 -0400
Date: Fri, 1 Jun 2001 20:23:24 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: CZUCZY Gergely <phoemix@mayday.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: isdn connecting error(auth failed) with 2.4.4-ac9 and
 2.4.5
In-Reply-To: <Pine.LNX.4.21.0105312020010.20643-100000@hirosima.martos.bme.hu>
Message-ID: <Pine.LNX.4.33.0106011728360.1481-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001, CZUCZY Gergely wrote:

> May 27 15:00:50 kign kernel: ippp0: dialing 1 0651201201...
> May 27 15:00:51 kign kernel: isdn_net: ippp0 connected
> May 27 15:00:51 kign ipppd[391]: Local number: 2536889, Remote
> number: 0651201201, Type: outgoing
> May 27 15:00:51 kign ipppd[391]: PHASE_WAIT -> PHASE_ESTABLISHED,
> ifunit: 0, linkunit: 0, fd: 7
> May 27 15:00:52 kign ipppd[391]: Remote message: Access Denied
> May 27 15:00:52 kign ipppd[391]: PAP authentication failed
> May 27 15:00:52 kign ipppd[391]: LCP terminated by peer

That really looks more like an authentication problem. Is this problem
reproducible, and does it vanish if you go back to 2.4.4?

If the problem persists, contact me off list, and I'll try to sort it
out.

--Kai



