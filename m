Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRCDWRt>; Sun, 4 Mar 2001 17:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbRCDWRj>; Sun, 4 Mar 2001 17:17:39 -0500
Received: from mail2.mail.iol.ie ([194.125.2.193]:5382 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S130536AbRCDWRX>;
	Sun, 4 Mar 2001 17:17:23 -0500
Date: Sun, 4 Mar 2001 22:17:11 +0000
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: kmalloc() alignment
Message-ID: <20010304221711.A1023@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does kmalloc() make any guarantees of the alignment of allocated
blocks?  Will the returned block always be 4-, 8- or 16-byte
aligned, for example?

Later,
Kenn

