Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTK2JZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTK2JZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:25:11 -0500
Received: from [210.8.79.18] ([210.8.79.18]:42127 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S263758AbTK2JZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:25:08 -0500
Date: Sat, 29 Nov 2003 20:24:25 +1100
To: Dave Jones <davej@redhat.com>, Aubin LaBrosse <arl8778@rit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: DRI and AGP on 2.6.0-test9
Message-ID: <20031129092425.GA1057@dreamcraft.com.au>
References: <1069571959.9574.46.camel@rain.rh.rit.edu> <20031123193724.GA24957@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031123193724.GA24957@redhat.com>
User-Agent: Mutt/1.5.4i
From: tmc@dreamcraft.com.au (Tomasz Ciolek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That make it ...  work... 

why was it not documented somewhere??

TMC

On Sun, Nov 23, 2003 at 07:37:24PM +0000, Dave Jones wrote:
>  > of particular worry to me, though i'm not a kernel hacker, is the line
>  > [agp] AGP not available.
> 
> Did you modprobe the amd-k7-agp module as well as agpgart ?
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tomasz M. Ciolek	
*******************************************************************************
  email:  tmc at dreamcraft dot com dot au 
*******************************************************************************
	GPG Key ID: 0x41C4C2F0  Key available on www.pgp.net	
*******************************************************************************
  Everything falls under the law of change;	
  Like a dream, a phantom, a bubble, a shadow,
  like dew of flash of lightning.
  You should contemplate like this. 
