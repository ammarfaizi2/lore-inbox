Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269508AbRGaWkZ>; Tue, 31 Jul 2001 18:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRGaWkF>; Tue, 31 Jul 2001 18:40:05 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:2526 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269508AbRGaWjz>;
	Tue, 31 Jul 2001 18:39:55 -0400
Message-Id: <200107312240.AAA1557144@mail.takas.lt>
Date: Wed, 1 Aug 2001 00:37:45 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: cannot copy files larger than 40 MB from CD
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

Just began to use 2.4.7 instead of 2.2.19. If I copy file larger than 40 MB,
only these 40 MB are copied (40960000 bytes exactly), and then cp
segfaults (the same happens with mc). The same problem is with mkisofs -
only 40 MB of image is created. I get "File size limit exceeded".

Regards,
Nerijus


