Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277298AbRJQXsw>; Wed, 17 Oct 2001 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277300AbRJQXsm>; Wed, 17 Oct 2001 19:48:42 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:6362 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S277298AbRJQXsc>; Wed, 17 Oct 2001 19:48:32 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E49B@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kernel command line parameters/insmod cmdline parameters
Date: Wed, 17 Oct 2001 17:49:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

Is there any limitation on the length of the parameter string or
the number of parameters that can be passed to the kernel command-line
(probably using append=".." in the lilo.conf or directly on lilo prompt)
or the insmod command-line when loading a module ? (e.g. insmod aic7xxx
aic7xxx="....").

Thanks & regards,
-hiren
