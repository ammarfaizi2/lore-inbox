Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRCGJI6>; Wed, 7 Mar 2001 04:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCGJIs>; Wed, 7 Mar 2001 04:08:48 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:27126 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130446AbRCGJIn>; Wed, 7 Mar 2001 04:08:43 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200103070907.KAA05202@sunrise.pg.gda.pl>
Subject: Re: IP autoconfig via DHCP?
To: kenn@linux.ie (Kenn Humborg)
Date: Wed, 7 Mar 2001 10:07:29 +0100 (MET)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20010307020020.A29103@excalibur.research.wombat.ie> from "Kenn Humborg" at Mar 07, 2001 02:00:20 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenn Humborg wrote:"
> 
> Back in 2.2, we could use DHCP to auto-config the IP setup.  In fact,
> the choice was DHCP, BOOTP or RARP.
> 
> Now there is only BOOTP or RARP.  What happened to DHCP support?

Nothing. It has been implemented in 2.2 very late and has never been ported
to 2.3/2.4 kernels.

Andrzej
