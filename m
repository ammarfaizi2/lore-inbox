Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUC0MOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 07:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUC0MOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 07:14:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:60424 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261706AbUC0MO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 07:14:29 -0500
Date: Sat, 27 Mar 2004 12:14:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: uClinux development list <uclinux-dev@uclinux.org>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [ANNOUNCE] 2.6.4-hsc1 patch for MMU-less ARM is available.
Message-ID: <20040327121424.A17991@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Hyok S. Choi" <hyok.choi@samsung.com>,
	uClinux development list <uclinux-dev@uclinux.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <000401c413dd$fb0649d0$7dc2dba8@dmsst.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000401c413dd$fb0649d0$7dc2dba8@dmsst.net>; from hyok.choi@samsung.com on Sat, Mar 27, 2004 at 06:29:19PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 06:29:19PM +0900, Hyok S. Choi wrote:
> Hello ARM users!
> 
> MMU-less ARM patch against linux-2.6.4 kernel, linux-2.6.4-hsc1 patch is
> available at:
> http://adam.kaist.ac.kr/~hschoe
> 
> The ATMEL AT91xx(ARM7TDMI) platform support is added, which means
> GDB/ARMulator is supported also. And proc-arm940.S is included. (contributed
> by Hee-Chul Yun)
> 
> You can download it directly at :
> http://adam.kaist.ac.kr/~hschoe/download/linux-2.6.4-hsc1.patch.gz
> 
> This patch pending to be merged to 2.6.4-uc0 patch.

Is the code really that different that you need a armnommu arch instead
of merging it into arch/arm?

> 
> Happy Hacking!
> 
> Regards,
> Hyok S. Choi
> 
> <EOT>
> 
> CHOI, HYOK-SUNG
> Engineer (Linux System Software)
> S/W Platform Lab, Digital Media R&D Center
> Samsung Electronics Co.,Ltd.
> tel: +82-31-200-8594  fax: +82-31-200-3427
> e-mail: hyok.choi@samsung.com
> 
> [compile&run]
> main(a){printf(a,34,a="main(a){printf(a,34,a=%c%s%c,34);}",34);}
> 
>  
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
