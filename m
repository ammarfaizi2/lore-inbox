Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVBXWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVBXWhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVBXWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:37:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:44694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVBXWfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:35:06 -0500
Date: Thu, 24 Feb 2005 14:35:09 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Marvell 88W8310 and 88E8050 PCI Express support
Message-ID: <20050224143509.4fe2a6a8@dxpl.pdx.osdl.net>
In-Reply-To: <a728f9f905022413465b96acd4@mail.gmail.com>
References: <a728f9f905022413465b96acd4@mail.gmail.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 16:46:34 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> I've noticed most of the new AMD64 chipsets now include integrated
> marvell GigE and wifi chips onboard.  I haven't been able to find much
> on the status of linux support for these chips.  Apparently the PCIE
> GigE chip only works with sk98lin

You need to use the version from SysKonnect.  If you look at the source
for that, you will see why I started on the skge driver.


> http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0010.html
> Does anyone know if support for the chip is being added to skge? 

As soon as I get the hardware (on order), or a donation of a new system.
Then I will report the interface from sk98lin.

> The
> 88W8310 doesn't seem to be supported at all, at least not that I can
> see.  Does anyone know the status of the 88W8310?  Are there any
> experimental drivers?  Is Marvell friendly to opensource?  Are the
> databooks available?

If you find databook for Yukon 2 chipset let me know.  I found the original
Yukon and Genesis manuals, but nothing newer.
