Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271309AbRIJPw7>; Mon, 10 Sep 2001 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIJPwi>; Mon, 10 Sep 2001 11:52:38 -0400
Received: from lan212095014004.ibk.telering.at ([212.95.14.4]:61466 "HELO
	lan212095014004.ibk.telering.at") by vger.kernel.org with SMTP
	id <S271309AbRIJPwe>; Mon, 10 Sep 2001 11:52:34 -0400
Message-ID: <853DD5D67AF0D411A3300000D1DD5C3B260EF1@dsw89.wattens.swarovski.com>
From: Suessmilch Bernd <Bernd.Suessmilch@SWAROVSKI.COM>
To: "'Mark Hahn'" <hahn@physics.mcmaster.ca>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.x, mlockall() and pthreads: exceptionally huge memory dem
	ands
Date: Mon, 10 Sep 2001 17:52:34 +0200
X-Mailer: Internet Mail Service (5.5.2650.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > are you sure it's not just a glibc/libpthread difference?
> that is, did you boot the same machine with both kernels?
Uuuh, you are right. It seems to depend on the version of
glibc/libpthread. It depends obviously not on the kernel. 

I apologize for any inconvenience and thank you for your assistance.
Regards,
Bernd 
