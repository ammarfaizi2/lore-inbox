Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHCPxU>; Fri, 3 Aug 2001 11:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269432AbRHCPxA>; Fri, 3 Aug 2001 11:53:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45952 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269431AbRHCPw7>; Fri, 3 Aug 2001 11:52:59 -0400
Date: Fri, 3 Aug 2001 09:51:41 -0600
Message-Id: <200108031551.f73FpfN05678@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: "'Todd'" <todd@unm.edu>, linux-kernel@vger.kernel.org
Subject: RE: PCI bus speed
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC53A@elway.lss.emc.com>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC53A@elway.lss.emc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xiangping chen writes:
> yes. I see some items with flags listed as:
> 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10    
> 
> Is it suppose to mean that the bus freq is 66Mhz?

I don't think so. That's the CPU<->bridge speed, not the speed that
cards plugged in could talk at.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
