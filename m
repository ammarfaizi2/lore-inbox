Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVGFN0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVGFN0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 09:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGFN0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 09:26:07 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62983 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262107AbVGFJtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:49:23 -0400
Date: Wed, 6 Jul 2005 11:10:34 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: compilation error sound/pci/bt87x.c:807 [Re: Linux 2.6.13-rc2]
Message-ID: <20050706091034.GA9095@irc.pl>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   CC [M]  sound/pci/bt87x.o
sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
sound/pci/bt87x.c:807: error: for each function it appears in.)
make[2]: *** [sound/pci/bt87x.o] Error 1
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2


-- 
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

