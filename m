Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277612AbRJVSut>; Mon, 22 Oct 2001 14:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJVSuj>; Mon, 22 Oct 2001 14:50:39 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36708 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277612AbRJVSu2>; Mon, 22 Oct 2001 14:50:28 -0400
Date: Mon, 22 Oct 2001 14:51:01 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: jarausch@belgacom.net, support@nvidia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011022145101.H23213@redhat.com>
Reply-To: support@nvidia.com
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be>; from jarausch@belgacom.net on Mon, Oct 22, 2001 at 08:45:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please take this issue up with the provider of that driver.  If they 
were to provide source for the driver, we'd be glad to help you, but 
unfortunately that is not the case.

		-ben

On Mon, Oct 22, 2001 at 08:45:22PM +0200, jarausch@belgacom.net wrote:
> Hello,
> 
> yes I know, you don't like modules without full sources available.
> But Nvidia is the leading vendor of video cards and all 2.4.x
> kernels up to 2.4.13-pre5 work nice with this module.
> 
> Running pre6 I get
> (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> (EE) NVIDIA(0): Failed to allocate LUT context DMA
> (EE) NVIDIA(0):  *** Aborting ***
> 
> 
> This is Nvidia's 1.0-1541 version of its Linux drivers
> 
> Please keep this driver going during the 2.4.x series of the
> kernel if at all possible.
> 
> Thanks for looking into it,
> 
> Helmut Jarausch
> 
> Inst. of Technology
> RWTH Aachen
> Germany
> 
> 
> Please CC to my private email
> 
> jarausch@belgacom.net
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"I can't tell you how many bridges I've jumped off of -- all I get is wet."
