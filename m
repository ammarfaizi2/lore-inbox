Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTIWM4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbTIWM4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:56:05 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:1411 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263359AbTIWM4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:56:02 -0400
Date: Tue, 23 Sep 2003 14:55:57 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Mike Galbraith <efault@gmx.de>,
       german aracil boned <german@tecnoxarxa.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: ATTACK TO MY SYSTEM
In-Reply-To: <20030923131715.C1299@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.51.0309231447020.1116@dns.toxicfilms.tv>
References: <5.2.1.1.2.20030923114213.01b36e78@pop.gmx.net> <3F703614.4060403@euronext.nl>
 <20030923131715.C1299@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When there are enough complaints to mail server admins, hopefully the
> philosophy will change.
It is changing. I have been talking to antivirus software people (nod32)
and I suggested that their virus signatures could have information whether
the virus spoofs the sender address or not, and then simply do not send
replies for infected mail. I got a response that they are working on it,
and that other antivirus software developers like dudes from symantec,
sophos, mcaffe, etc... are working on it also.

So we should have a slightly better solution to that when the software
gets better.

Also note the disinformative effect of the virus on plain users.
We will have all of these problem until the protocols get seriously
improved. We urgently need a reliable and secure SMTP replacing or
extending protocol, which would aid in tracking down the culprits.
TCP/IP Ideas like icmp traceback messages (it's still an IETF draft)
and other ideas will hopefully help us cut down on spoofing, flooding,
etc, as the detection will improve. Anyway these are my wishes for the
Internet Community. The protocols we are using today (SMTP, IP) are
inadequate due to lacks in their defensive value.

I also heard that there is work in progress conerning SMTP
replacement/improvement by enhancements.

Regards,
Maciej
