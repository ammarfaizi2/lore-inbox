Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276745AbRJPWgK>; Tue, 16 Oct 2001 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276800AbRJPWgB>; Tue, 16 Oct 2001 18:36:01 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61923 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276745AbRJPWfp>; Tue, 16 Oct 2001 18:35:45 -0400
Date: Tue, 16 Oct 2001 15:33:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "J . A . Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cross Quad Port...?
Message-ID: <2519001985.1003246381@mbligh.des.sequent.com>
In-Reply-To: <20011017002440.A29367@werewolf.able.es>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you turn on CONFIG_MULTIQUAD?
If so, don't.

--On Wednesday, October 17, 2001 12:24 AM +0200 "J . A . Magallon" <jamagallon@able.es> wrote:

> Hi.
> 
> When booting 2.4.12-ac2 on a dual PIII box, ServerWorks HE-SL, boot sequence
> stops at:
> 
> Cross Quad Port I/O vaddr 0xd0800000, len 00040000
> 
> What the h**l is that ??
> 
> TIA
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.12-ac3-beo #2 SMP Tue Oct 16 01:08:46 CEST 2001 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


