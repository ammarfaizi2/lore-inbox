Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271254AbRHOQHh>; Wed, 15 Aug 2001 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271256AbRHOQH1>; Wed, 15 Aug 2001 12:07:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46347 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271254AbRHOQHM>; Wed, 15 Aug 2001 12:07:12 -0400
Subject: Re: Via chipset
To: bdbryant@mail.utexas.edu (Bobby D. Bryant)
Date: Wed, 15 Aug 2001 17:09:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Bobby D. Bryant" at Aug 15, 2001 07:28:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X3Ey-0003SU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > We know it happens on some boards that apparently cant keep up. We dont know
> > why, there is no time estimate for a cure. That unfortunately is about it
> 
> FWIW (qualitative data point), my EPoX system with the VIA chipset seems to run a
> few *hours* without an oops when I boot a PIII kernel and run it with X, but a few
> *days* on the same kernel when I don't start X.
> 
> Sometimes it barfs early even without X, but there seems to be a significant
> difference in the expected uptime between using X and not using X.

If you are running XFree servers then provide info on the card, the machine
configuration and XFree version, whether you use DRI or not. Also send the
same info to XFree86 themselves. It's entirely possible the Xserver is
the trigger some of the bugs, and getting the info to both parties will
really help
