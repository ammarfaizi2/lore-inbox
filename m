Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTE0PNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTE0PNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:13:25 -0400
Received: from mail.ithnet.com ([217.64.64.8]:61198 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263759AbTE0PNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:13:23 -0400
Date: Tue, 27 May 2003 17:26:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Werner.Beck@Lidl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Antwort: Re: Oops in Kernel 2.4.21-rc1
Message-Id: <20030527172631.56af611b.skraw@ithnet.com>
In-Reply-To: <OFBC4DE14D.84808A7E-ONC1256D33.005135A5-C1256D33.00523E77@lidl.de>
References: <OFBC4DE14D.84808A7E-ONC1256D33.005135A5-C1256D33.00523E77@lidl.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 16:58:19 +0200
Werner.Beck@Lidl.de wrote:

> we just did an update from 2.4.10-SuSE because of some problems with the
> hardware (module for NIC and HDD). In this constellation we also had a
> kernel oops with the ISDN ("killing interrupt handler") which unfortunately
> didn't give us any hints in the logs.

Take my advice: Don't waste time with 7.3 based setup. Simply take a 8.2. It is
way better. Applications should not have problems with such an upgrade. 

> The systems are a field test and running an application that's why it is a
> problem to access them. I think a cause has an effect. The ISDN was not
> active at that time but probably a job of the SuSE distri, but I can't
> imagine that this causes kernel problems.
>  I will run a test in our lab and hope to get the error, then I can do some
> changes with the system.
> Thanks for your hints...

Your problem is this: even your old 7.3 should not crash no matter what cron
does around midnight. It makes no sense to find out _what_ crashes the box, you
won't probably find the real cause, so in the end you are only taking a
work-around instead of a real solution.

On the other hand: if you take a state-of-the-art distro chances are you won't
see your problem any more, have spent about the same time, but come out with a
new and fine solution.

Regards,
Stephan



