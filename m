Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSCRLWj>; Mon, 18 Mar 2002 06:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSCRLWc>; Mon, 18 Mar 2002 06:22:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58123 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292971AbSCRLWS>; Mon, 18 Mar 2002 06:22:18 -0500
Subject: Re: Another entry for the MCE-hang list
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Mon, 18 Mar 2002 11:37:53 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <200203180611.g2I6BOk13021@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Mar 17, 2002 11:11:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mvSb-0004q9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The "running ok" case, which came -after- the hang case, was 
> > 2.4.19-pre3-BK-latest with gcc 3.0.4-MDK.
> 
> I'm using egcs-1.1.2. I've bailed out of gcc-2.95.3 because it's
> buggy. 

egcs-1.1.2 is known to miscompile some driver code and other oddments in
2.4. 


