Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRCWJoU>; Fri, 23 Mar 2001 04:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbRCWJoK>; Fri, 23 Mar 2001 04:44:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41228 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130439AbRCWJoC>; Fri, 23 Mar 2001 04:44:02 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: timw@splhi.com
Date: Fri, 23 Mar 2001 09:45:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        twoller@crystal.cirrus.com (Woller Thomas), andrew.grover@intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010322174233.A1651@kochanski.internal.splhi.com> from "Tim Wright" at Mar 22, 2001 05:42:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gO8Z-0004Lw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it's a 500MHz Thinkpad, then I'm guessing it's something like a 600X.
> That doesn't have Speedstep. The speed changes are done by some circuitry
> in the laptop. I can try to find out more if this would help.
> The newer machines are using Speedstep.

Ok

Any info on how the laptop wants to tell the OS about CPU speed changes that
we can hook into would be wonderful

