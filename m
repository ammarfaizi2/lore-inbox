Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbTBSEvJ>; Tue, 18 Feb 2003 23:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268883AbTBSEvJ>; Tue, 18 Feb 2003 23:51:09 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:61831 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267972AbTBSEvI>; Tue, 18 Feb 2003 23:51:08 -0500
Message-Id: <200302190501.h1J511Gi002225@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore 
In-reply-to: Your message of "18 Feb 2003 20:47:36 PST."
             <1045630056.10926.4.camel@rth.ninka.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 19 Feb 2003 00:01:01 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1045630056.10926.4.camel@rth.ninka.net>,"David S. Miller" writes:
>Anyways, Matt, without a full time ATM maintainer and having basically
>nobody who wants to take that on, we should take the small fixes when
>they do occur and are correct as Chas's patch is.

we (meaning some folks here at nrl) already maintain a seperate 
kernel with atm 'enhancements' locally.  we are very interested in keeping
linux-atm alive (particularly in the linux kernel) and extending it
as well.  i would take the role of maintainer for atm if no one truly
wants it.
