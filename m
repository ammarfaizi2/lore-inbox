Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTI1UDX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTI1UDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:03:23 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:52621 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262707AbTI1UDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:03:14 -0400
Subject: [2.6.0-test6] ALSA: Trident (sis7018) depends on gameport?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064778653.1466.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 28 Sep 2003 21:50:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried 2.6.0-test6 on my SIS630 based PIII-M laptop. I was
unable to select the trident ALSA driver for my sis7018 built in sound.
Further investigation revealed it now all of a sudden depends on the
game port being selected as well. My laptop doesn't have a game port at
all so I never built game port drivers.

Is the trident driver really dependable om the gameport? What can be a
solution here?

Thanks,

Jurgen
  

