Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272460AbRIKPBG>; Tue, 11 Sep 2001 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRIKPA4>; Tue, 11 Sep 2001 11:00:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268071AbRIKPAl>; Tue, 11 Sep 2001 11:00:41 -0400
Subject: Re: Kernel Panic: Aiee, Killing Interupt Handler, Process kpnpbios
To: paulhamm@OpenRatings.com (Paul Hamm)
Date: Tue, 11 Sep 2001 16:05:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4A46E75D51A2D5119F2A00B0D03D7F09018D@exchange.hq.openratings.com> from "Paul Hamm" at Sep 10, 2001 01:27:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15gp6G-0002q6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The complete screen of the error is below, there is one error in the second
> block of the STACK info.  Had to hand write it and did not notice until I
> typed it out.
> 

You need to run that through ksymoops. Also the roswell beta kernel is 2.4.6
based with known bugs and other test patches, so you probably want to pick
up a more recent kernel 
