Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbTCTAWW>; Wed, 19 Mar 2003 19:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTCTAWW>; Wed, 19 Mar 2003 19:22:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263068AbTCTAWV>;
	Wed, 19 Mar 2003 19:22:21 -0500
Date: Wed, 19 Mar 2003 16:31:05 -0800 (PST)
Message-Id: <20030319.163105.44963500.davem@redhat.com>
To: dlstevens@us.ibm.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] anycast support for IPv6, updated to 2.5.44 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFC909BFEE.F581E26E-ON88256C60.0072A662@boulder.ibm.com>
References: <OFC909BFEE.F581E26E-ON88256C60.0072A662@boulder.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David Stevens" <dlstevens@us.ibm.com>
   Date: Mon, 28 Oct 2002 14:06:00 -0700
   
   Below is a patch to add anycast support for IPv6. It's the same patch as
   I've posted previously, but updated with comments from Chris Hellwig and
   for kernel version 2.5.44.

I'm going to apply this, with the small change that dev_getany() is
renamed to dev_get_by_flags() which more accurately describes
what the routine does.

Thanks David.
