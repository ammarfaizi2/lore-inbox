Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268884AbTBSE7K>; Tue, 18 Feb 2003 23:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbTBSE7K>; Tue, 18 Feb 2003 23:59:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38845 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268884AbTBSE7J>;
	Tue, 18 Feb 2003 23:59:09 -0500
Date: Tue, 18 Feb 2003 20:53:25 -0800 (PST)
Message-Id: <20030218.205325.14347725.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302190501.h1J511Gi002225@locutus.cmf.nrl.navy.mil>
References: <1045630056.10926.4.camel@rth.ninka.net>
	<200302190501.h1J511Gi002225@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 19 Feb 2003 00:01:01 -0500
   
   we (meaning some folks here at nrl) already maintain a seperate 
   kernel with atm 'enhancements' locally.  we are very interested in keeping
   linux-atm alive (particularly in the linux kernel) and extending it
   as well.  i would take the role of maintainer for atm if no one truly
   wants it.
   
This is the situation.

Therefore, please send me a patch to add an appropriate entry
to linux/MAINTAINERS.

Thank you.
