Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVIFTSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVIFTSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVIFTSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:18:03 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:64941 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750817AbVIFTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:18:02 -0400
Date: Tue, 6 Sep 2005 21:17:26 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: vortex@scyld.com
Cc: becker@scyld.com, jgarzik@pobox.com
Subject: Re: wakeup on lan enable without compiling as module
Message-ID: <20050906191726.GK26445@cip.informatik.uni-erlangen.de>
References: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,
I have a few other problems with 2.6.13 (and also 2.6.12.5). When I pull
the ethernet plug from my card when the net is configured out and put it
back in, I have connectivity for about two till three seconds and after
that the card doesn't handle any more traffic. It did not happen with
the kernel I had before 2.6.12.5, but I don't remember the version.

0000:00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)

Also I would like to know how can I put the card in wake-up-on-lan modus
when I use Magic Sysrq - O to turn it off.

Thanks,
	Thomas
