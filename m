Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130686AbRCZOub>; Mon, 26 Mar 2001 09:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRCZOuU>; Mon, 26 Mar 2001 09:50:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10253 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130686AbRCZOuC>; Mon, 26 Mar 2001 09:50:02 -0500
Subject: Re: ac25 - hang mounting swap
To: jamagallon@able.es (J . A . Magallon)
Date: Mon, 26 Mar 2001 15:52:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010326114713.A1150@werewolf.able.es> from "J . A . Magallon" at Mar 26, 2001 11:47:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14hYLr-0001mv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It just hangs when init scripts try to activate swap. I will look at
> what is init trying to mount and decode the info that Sysrq-P gives,
> but if this suggests somebody anything already known...

PAE or non PAE

> Sysrq-p gives different info as time goes, so perhaps it is not stuck
> but caught in an infinite loop trying to mount the only swap partition
> I have.

See what it is looping through if you can
