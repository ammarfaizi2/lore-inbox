Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135998AbRD0LxZ>; Fri, 27 Apr 2001 07:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136003AbRD0LxP>; Fri, 27 Apr 2001 07:53:15 -0400
Received: from c4.h061013036.is.net.tw ([61.13.36.4]:31494 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S135998AbRD0LxM>; Fri, 27 Apr 2001 07:53:12 -0400
Message-ID: <611C3E2A972ED41196EF0050DA92E0760265D57A@EXCHANGE2>
From: Yiping Chen <YipingChen@via.com.tw>
To: "'kernel@kvack.org'" <kernel@kvack.org>,
        Yiping Chen <YipingChen@via.com.tw>
Cc: "'Vivek Dasmohapatra'" <vivek@etla.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
Date: Fri, 27 Apr 2001 19:53:04 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a important question about compile driver here, sometimes we install
RedHat Linux
When you boot the system , it will not include the kernel source, if we
don't have kernel source ,
whether can we compile the driver (NIC).
I am confused, beacuse we need include many kernel header file, if you don't
have linux kernel 
source (I means that there is no kernel source in /usr/src, whether we can
compile the driver module
successfully?), whether we can just use the header file in /usr/include?
thanks!!
Yiping Chen
