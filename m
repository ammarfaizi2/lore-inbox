Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132251AbRCVXft>; Thu, 22 Mar 2001 18:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbRCVXfk>; Thu, 22 Mar 2001 18:35:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132251AbRCVXfb>; Thu, 22 Mar 2001 18:35:31 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: twoller@crystal.cirrus.com (Woller, Thomas)
Date: Thu, 22 Mar 2001 23:37:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), andrew.grover@intel.com,
        twoller@crystal.cirrus.com (Woller Thomas),
        linux-kernel@vger.kernel.org
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F077@csexchange.crystal.cirrus.com> from "Woller, Thomas" at Mar 22, 2001 05:26:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEeH-0003Z4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	thanks, i just tested the "notsc" option (.config has CONFIG_X86_TSC
> enabled=y, but CONFIG_M586TSC is not enabled.. if that's ok), but this time
...
> boot and stay on battery power exclusively.  did anyone else expect this
> behaviour?  

Errmm no.. 

