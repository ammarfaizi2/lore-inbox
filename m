Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132641AbRAQRbG>; Wed, 17 Jan 2001 12:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRAQRa4>; Wed, 17 Jan 2001 12:30:56 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:4874 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S132641AbRAQRaj>;
	Wed, 17 Jan 2001 12:30:39 -0500
Message-ID: <3A65D60E.188C88E6@ihug.co.nz>
Date: Thu, 18 Jan 2001 06:27:42 +1300
From: david <sector2@ihug.co.nz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: need help raid and 2.4.0
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi i am moving from 2.2.18 to 2.4.0 i have a ide raid set but can not
get it to run under 2.4.0
i user mdadd / mdrun to config it. in raid-tools 0.42 but it dose not
come up under 2.4.0 it just says unknow devices /dev/hda3 & /dev/hdc3
but thay are thear and when i try to compile raid-tools .53 undir 2.4.0
i get a lot of error in string.h (i am runing debian 2.2r2)
i configured the kernel

can someone help me i am reconfigering my raid set and i have a big
drive to hold the data but i only have it for 1 day

thank you
    David Rundle <sector2@ihug.co.nz>





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
