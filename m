Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315735AbSEJAZQ>; Thu, 9 May 2002 20:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315736AbSEJAZP>; Thu, 9 May 2002 20:25:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315735AbSEJAZP>; Thu, 9 May 2002 20:25:15 -0400
Subject: Re: PATCH & call for help: Marking ISA only drivers
To: ak@muc.de (Andi Kleen)
Date: Fri, 10 May 2002 01:18:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@muc.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020510011116.A1476@averell> from "Andi Kleen" at May 10, 2002 01:11:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175y7e-0004rI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I'm assuming that there are no boxes with no ISA slots but VLB slots.
> I guess that's safe. If someone really has a weird box were that is not true
> I guess they'll have to live with defining CONFIG_ISA. 
> In theory one could introduce an CONFIG_VLB, but I don't think it is 
> worth it.

Agreed

