Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTEIBLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 21:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTEIBLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 21:11:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41615 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261916AbTEIBLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 21:11:23 -0400
Date: Thu, 08 May 2003 18:23:42 -0700 (PDT)
Message-Id: <20030508.182342.52884545.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: wa@almesberger.net, hch@infradead.org, romieu@fr.zoreil.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE
 he_init_one() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305090058.h490wNGi006609@locutus.cmf.nrl.navy.mil>
References: <20030508194700.C13069@almesberger.net>
	<200305090058.h490wNGi006609@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 08 May 2003 20:58:23 -0400

   this patch should make the he code a bit more palatable.  it drops any
   of the < 2.3 support left over the good 'ole days and puts all the
   compatibility code in a single place.
   
Applied, thanks.
