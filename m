Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280630AbRKBJzI>; Fri, 2 Nov 2001 04:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280633AbRKBJy6>; Fri, 2 Nov 2001 04:54:58 -0500
Received: from riker.skynet.be ([195.238.3.132]:16232 "EHLO riker.skynet.be")
	by vger.kernel.org with ESMTP id <S280630AbRKBJyv>;
	Fri, 2 Nov 2001 04:54:51 -0500
Message-Id: <200111020954.fA29sf413054@riker.skynet.be>
Date: Fri, 2 Nov 2001 10:53:39 +0000 (europe)
From: jarausch@belgacom.net
Reply-To: jarausch@belgacom.net
Subject: 2.4.14-pre7 Unresolved symbols
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to build 2.4.14-pre7 breaks with the error message
depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
depmod:         unlock_page

during make modules_install.

2.4.14-pre6 is running fine here.

Thank for hint,
Helmut Jarausch

Inst. of Technology
RWTH Aachen
Germany


