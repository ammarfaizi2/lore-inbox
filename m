Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSGUATx>; Sat, 20 Jul 2002 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGUATx>; Sat, 20 Jul 2002 20:19:53 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:11270 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317598AbSGUATt>; Sat, 20 Jul 2002 20:19:49 -0400
Subject: 2.5.27 -- make mrproper error -- rm: `include/asm' is a directory
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1027210922.1861.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Jul 2002 20:22:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/linux/Documentation/DocBook'
Making mrproper
rm: `include/asm' is a directory
make: *** [mrproper] Error 1

