Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSJMRfE>; Sun, 13 Oct 2002 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbSJMRfE>; Sun, 13 Oct 2002 13:35:04 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:5131 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261560AbSJMRfD>;
	Sun, 13 Oct 2002 13:35:03 -0400
Date: Sun, 13 Oct 2002 19:40:41 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Watchdog drivers
Message-ID: <20021013194041.A15609@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm reviewing the different watchdog drivers and started porting the features 
that have been added in the 2.4 kernel to the 2.5 development kernel.
I now wondered if it would make sence to put all watchdog drivers in
drivers/char/watchdog/ instead of in drivers/char ?
Please comments.

Greetings,
Wim.

