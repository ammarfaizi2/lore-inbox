Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBVKjT>; Thu, 22 Feb 2001 05:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRBVKjJ>; Thu, 22 Feb 2001 05:39:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129093AbRBVKi7>; Thu, 22 Feb 2001 05:38:59 -0500
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
To: pat@isis.co.za (Pat Verner)
Date: Thu, 22 Feb 2001 10:42:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.0.20010222095007.00b9e260@192.168.0.18> from "Pat Verner" at Feb 22, 2001 09:56:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VtCQ-0003t2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> three Netgear NICs and am experiencing considerable trouble with the=20
> combination:
> 
> Kernel 2.4.[01]:        ifconfig shows that the card see's traffic on t=
> he=20
> network, but does not transmit anything (no response to ping).

Use a current 2.4.*-ac. Jeff and co fixed this we think.

Alan

