Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269391AbRHCOdC>; Fri, 3 Aug 2001 10:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHCOcy>; Fri, 3 Aug 2001 10:32:54 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:30986 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S269386AbRHCOcm>; Fri, 3 Aug 2001 10:32:42 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC53A@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Todd'" <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PCI bus speed
Date: Fri, 3 Aug 2001 10:27:10 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes. I see some items with flags listed as:
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10    

Is it suppose to mean that the bus freq is 66Mhz?

Thanks,

Xiangping

-----Original Message-----
From: Todd [mailto:todd@unm.edu]
Sent: Thursday, August 02, 2001 8:03 PM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bus speed


xiangping,

try

lspci -v

the info you want is there.

todd

On Thu, 2 Aug 2001, chen, xiangping wrote:

> Date: Thu, 2 Aug 2001 18:47:49 -0400
> From: "chen, xiangping" <chen_xiangping@emc.com>
> To: linux-kernel@vger.kernel.org
> Subject: PCI bus speed
>
> Hi,
>
> Is there any easy way to probe the PCI bus speed
> of an Intel box?
>
> Thanks,
>
> Xiangping
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

=========================================================
Todd Underwood, todd@unm.edu

=========================================================
