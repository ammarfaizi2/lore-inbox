Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270409AbTGRW7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271904AbTGRW7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:59:47 -0400
Received: from mail.egps.com ([38.119.130.6]:58116 "EHLO egps.com")
	by vger.kernel.org with ESMTP id S270409AbTGRW7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:59:39 -0400
Date: Fri, 18 Jul 2003 19:13:55 -0400
From: Nachman Yaakov Ziskind <awacs@egps.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Svein Ove Aas <svein.ove@aas.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DVD-RAM crashing system
Message-ID: <20030718191355.C25384@egps.egps.com>
References: <20030718160643.A21755@egps.egps.com> <200307190008.32137.svein.ove@aas.no> <1058568886.19512.111.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058568886.19512.111.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (on Fri, Jul 18, 2003 at 11:54:46PM +0100):
> On Gwe, 2003-07-18 at 23:08, Svein Ove Aas wrote:
> > My suggestion is this: As the hardware is obviously broken, and disabling 
> > DMA would cause a horrendous performance drop anyway, you should get a new 
> > chipset. Return the one you have as broken.
> 
> Update to 2.4.20. That will put IDE disks into MWDMA2 on the Serverworks
> OSB4 and avoid the mistrigger with CD-ROM errors. The later serverworks
> (CSB5, CSB6) is fine btw but can hit the CD-ROM mistrigger too

I just did. Happiness is a machine that reboots remotely. Emboldened by my
success, I started a backup. Works like a charm, too. I hope my luck holds up!

How sweet it is.

Thanks to all who responded.

-- 
_________________________________________
Nachman Yaakov Ziskind, EA, LLM         awacs@egps.com
Attorney and Counselor-at-Law           http://yankel.com
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
