Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272870AbRIGWMW>; Fri, 7 Sep 2001 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272871AbRIGWMM>; Fri, 7 Sep 2001 18:12:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56585 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272870AbRIGWL4>; Fri, 7 Sep 2001 18:11:56 -0400
Subject: Re: "Cached" grows and grows and grows...
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Fri, 7 Sep 2001 23:15:36 +0100 (BST)
Cc: mcelrath@draal.physics.wisc.edu (Bob McElrath),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010907191349.457cad95.skraw@ithnet.com> from "Stephan von Krawczynski" at Sep 07, 2001 07:13:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fTuS-0002g1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To tell you the honest truth: you are not alone in cosmos (with this problem)
> ;-)
> To give you that explicit hint for saving money: do not buy mem, it will be
> eaten up by recent kernels without any performance gain or other positive
> impact whatsoever. 

Pick up a 2.4.9-ac kernel, and you shouldnt be seeing the problem (I say
shouldnt, I'm not 100% convinced its all under control)

> Try using 2.4.4, if it doesn't succeed, forget 2.4 and use 2.2.19. That works.
> Unfortunately you may have to completely reinstall your system when going back
> to 2.2.

That should not be needed at all. 
