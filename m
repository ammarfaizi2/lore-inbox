Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135750AbRDSXFq>; Thu, 19 Apr 2001 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135751AbRDSXFf>; Thu, 19 Apr 2001 19:05:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135750AbRDSXFY>; Thu, 19 Apr 2001 19:05:24 -0400
Subject: Re: ac10 ide-cd oopses on boot
To: jamagallon@able.es (J . A . Magallon)
Date: Fri, 20 Apr 2001 00:07:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20010420004914.A1052@werewolf.able.es> from "J . A . Magallon" at Apr 20, 2001 12:49:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qNWF-0008Jc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> the CD and gives the oops.

Can you back out the ide-cd changes Jens did and see if that fixes it ?

