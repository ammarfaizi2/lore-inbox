Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGGOv5>; Sun, 7 Jul 2002 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSGGOv4>; Sun, 7 Jul 2002 10:51:56 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:38338 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315946AbSGGOvz>;
	Sun, 7 Jul 2002 10:51:55 -0400
Date: Sun, 7 Jul 2002 16:54:15 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: Jes Sorensen <jes@trained-monkey.org>, davem@redhat.com,
       jgarzik@mandrakesoft.com
Subject: [PATCH] 2.5.25 - drivers/net/rrunner DMA mapping + pci init update
Message-ID: <20020707165414.A24135@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  5 patches, compile fine after each patch applied. URLed files contain extra 
description. No hardware for testing here (unused parts, anyone ?). 
Testers/feedback welcome.

http://www.cogenit.fr/linux/patches/2.5.25/rrunner-S10
  conversion to pci driver style init

http://www.cogenit.fr/linux/patches/2.5.25/rrunner-S11
  Rx/Tx descriptors extra helpers

http://www.cogenit.fr/linux/patches/2.5.25/rrunner-S12
  DMA mapping conversion I/II

http://www.cogenit.fr/linux/patches/2.5.25/rrunner-S13
  DMA mapping conversion II/II

http://www.cogenit.fr/linux/patches/2.5.25/rrunner-S14
  remaining virt_to_bus()

-- 
Ueimor
