Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbREUISD>; Mon, 21 May 2001 04:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbREUIRx>; Mon, 21 May 2001 04:17:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38926 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262400AbREUIRg>; Mon, 21 May 2001 04:17:36 -0400
Subject: Re: alpha iommu fixes
To: davem@redhat.com (David S. Miller)
Date: Mon, 21 May 2001 09:09:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        andrewm@uow.edu.au (Andrew Morton),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <15112.52566.955443.247834@pizda.ninka.net> from "David S. Miller" at May 21, 2001 01:09:58 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151kkp-0003UB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Look at the history of kernel API's over time. Everything that can
>  > go wrong eventually does.
> 
> I agree, and it will be dealt with in 2.5.x
> 
> The scsi layer in 2.4.x is simply not able to handle failure in these
> code paths, as Gerard Roudier has mentioned.

On that I am unconvinced. It is certainly grungy enough that fighting that war
in 2.5 makes sense however.


