Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbTFLRIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTFLRHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:07:03 -0400
Received: from mail.idoox.com ([194.213.203.154]:10252 "EHLO mail.idoox.com")
	by vger.kernel.org with ESMTP id S264905AbTFLRG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:06:27 -0400
Subject: Cisco Aironet mini-PCI wireless card (MPI-350) [Was: Re: Intel
	PRO/Wireless 2100 vs. Broadcom BCM9430x]
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
References: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
Content-Type: text/plain
Message-Id: <1055438410.930.15.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 19:20:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cisco's linux support is great until you have IBM's ThinkPad R40. With
this notebook, their newest Linux driver (version 2.0, older ones do not
support my card) module (mpi350.o) can't be inserted to kernel (oops and
module remains 'initializing' forever). Module is compiled successfully
against both 2.4.20 and 2.4.21-rc7 kernels.

I'm just fighting their bureaucracy (in support) and trying to reach
someone who actually wrote the driver (module says Roland Wilcher). I
want to help him with testing and provide him with all possible
information.

My other chance is to get working new driver from
http://airo-linux.sf.net, but there is no activity in last several
weeks.

Jan Mynarik


On Thu, 2003-06-12 at 17:16, Joel Jaeggli wrote:
> most laptop vendors that provide multiple wireless options also support 
> the cisco aironet minipci card, you can allways vote with your wallet if 
> you think linux support for wireless chipsets is valuable.
> 
> joelja
> 
> On Thu, 12 Jun 2003, Marc Sowen wrote:
> 
> > Hi everybody,
> > 
> > I hope this is not too off-topic, but the fact is that neither the Intel
> > PRO/Wireless 2100 (Centrino) chipset nor the Broadcom BCM9430x (e.g.
> > Dell Truemobile 1180/1300/1400) chipset is currently supported in Linux
> > due to FCC regulation problems.
> > 
> > Anyhow, I plan to get a new Notebook within the next 2 or 3 weeks and I
> > need to decide, whether to go for the Intel PRO/Wireless 2100 or the
> > Broadcom BCM9430x chipset. I know it's hard to say, but what do you
> > think, which company (Intel or Broadcom) is more likely to release the
> > necessary documents and/or drivers for their chipsets? Both companys
> > seem to ignore all inquiries concerning Linux support at the moment.
> > 
> > While we're at it, are there any news from the WLAN front?
> > 
> > Thank you!
> > 
> > Marc
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

