Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132288AbRCWAv3>; Thu, 22 Mar 2001 19:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132295AbRCWAvT>; Thu, 22 Mar 2001 19:51:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132287AbRCWAvJ>; Thu, 22 Mar 2001 19:51:09 -0500
Subject: Re: 2.4.2-ac21
To: lawrence@the-penguin.otak.com (Lawrence Walton)
Date: Fri, 23 Mar 2001 00:52:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010322162802.A909@the-penguin.otak.com> from "Lawrence Walton" at Mar 22, 2001 04:28:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gFoy-0003h9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello all
> 2.4.2-ac21 seems to have a couple problems. First the fs was acting very
> strangely, while compiling; the compiler complained about being unable
> to find files and directory's that existed. I was able to cd to those
> directory's and see the files with ls, (I was recompiling ac20 at the
> time.). Second was every half a minute or so, I would get this message.


Ok the further VIA bitfiddling with the pci config is causing the problems
it seems. I'll back that out soon

