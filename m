Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTDQQSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDQQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:18:31 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:54159 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261697AbTDQQSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:18:30 -0400
Date: Thu, 17 Apr 2003 18:30:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Duplicate CONFIG_TULIP_MWI
Message-ID: <Pine.GSO.4.21.0304171829030.10220-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_TULIP_MWI is duplicated in
linux-2.4.21-pre7/Documentation/Configure.help. Which one is correct?


New Tulip bus configuration
CONFIG_TULIP_MWI 
  This configures your Tulip card specifically for the card and
  system cache line size type you are using.

  This is experimental code, not yet tested on many boards.

  If unsure, say N.


New bus configuration (EXPERIMENTAL)  
CONFIG_TULIP_MWI
  This configures your Tulip card specifically for the card and
  system cache line size type you are using.

  This is experimental code, not yet tested on many boards.

  If unsure, say N.


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

