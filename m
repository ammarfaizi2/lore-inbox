Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTHQQHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTHQQHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:07:10 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:14340 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S270384AbTHQQHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:07:09 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Russell King <rmk@arm.linux.org.uk>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Clean up yenta_socket
Date: Sun, 17 Aug 2003 18:02:22 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308171802.22413.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied the patches...seems to work fine. no problems on boot,
eject/insert, suspend/resume with APM also works fine.
some system info:
- toshiba tecra 8000 laptop, 440BX chipset
- toshiba ToPIC97 CardBus controller
- Xircom CE3B 16-bit PCMCIA network card.

rgds
-daniel

