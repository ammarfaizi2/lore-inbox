Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWILUg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWILUg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWILUg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:36:29 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:8609 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S1030423AbWILUg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:36:28 -0400
Subject: Re: Linux 2.6.15 - 2.6.16 bad page with fglrx 8.28.8 on Radeon X300
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Marco <marco4ever@libero.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450718A6.4070301@libero.it>
References: <450718A6.4070301@libero.it>
Content-Type: text/plain
Organization: iNES Group
Date: Tue, 12 Sep 2006 23:35:59 +0300
Message-Id: <1158093359.3939.2.camel@DustPuppy.LNX.RO>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-1.fc6) 
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 22:29 +0200, Marco wrote:
> Hi,
> 
> I cannot get back to a console after logging out from a Gnome/X session.
> I just got a blank screen which does not response to any key press.
> I have to turn off the power. This happens on a IBM Thinkpad T43p with 
> ATI RADEON X300 and
> with the non-free ATI driver fglrx 8.28.8 and kernels 2.6.15 / 2.6.16
> 
> I have found this patch (http://lkml.org/lkml/2005/12/11/26) for ATI 
> driver fglrx 8.20.8-1 that
> works very well with fglrx 8.20.8-1 driver.
> 
> Could you help me to make a patch for ATI driver fglrx 8.28.8 and 
> kernels 2.6.15 / 2.6.16?

You need to talk to ATI about that.

Btw, the free driver for the R300 series is quite useable right now, no
need for the fglrx driver.

I have an ATI RADEON X600 using the free driver, and I enabled compiz
and started bragging to my colleagues about the nifty eye candy.


-- 
Cioby


