Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbTDAQTi>; Tue, 1 Apr 2003 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbTDAQTe>; Tue, 1 Apr 2003 11:19:34 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:45489 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262639AbTDAQSI>; Tue, 1 Apr 2003 11:18:08 -0500
Message-Id: <200304011628.h31GSXGi000846@locutus.cmf.nrl.navy.mil>
To: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] second pass at fixing atm spinlock 
In-reply-to: Your message of "Thu, 27 Mar 2003 17:28:28 EST."
             <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 01 Apr 2003 11:28:33 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch

i have made an equivalent version of these patches for 2.4.20 in hopes
of getting more feedback.

ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_4_20_atm_dev_lock.patch

(only the nicstar, fore200e, eni and he (included) driver support the
new smp 'safe' locking)
