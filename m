Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136298AbRECJgs>; Thu, 3 May 2001 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136309AbRECJgj>; Thu, 3 May 2001 05:36:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49669 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136298AbRECJgd>; Thu, 3 May 2001 05:36:33 -0400
Subject: Re: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4
To: Martin.Knoblauch@TeraPort.de (Martin.Knoblauch)
Date: Thu, 3 May 2001 10:38:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF10956.7580E25F@TeraPort.de> from "Martin.Knoblauch" at May 03, 2001 09:31:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFZb-0005GA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  my DE-620 pccard stopped working after upgrading the kernel from
> 2.4.3-ac7 to 2.4.4. This is on a Toshiba 4080XCDT. I used the "good"
> .config from the 2.4.3-ac7 build to do a make "oldconfig". The symptoms
> at startup are:

2.4.4 has older pcmcia than 2.4.3-ac7. It might be that. Does 2.4.4-ac work ?

