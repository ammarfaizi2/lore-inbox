Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBUHrn>; Wed, 21 Feb 2001 02:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129127AbRBUHrd>; Wed, 21 Feb 2001 02:47:33 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:15369 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129098AbRBUHrX>;
	Wed, 21 Feb 2001 02:47:23 -0500
Message-ID: <3A93730B.1050409@megapathdsl.net>
Date: Tue, 20 Feb 2001 23:49:31 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac12 i686; en-US; 0.8) Gecko/20010220
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac20 -- SMP option + Athlon target still causes the build to break
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use 
in this function)

