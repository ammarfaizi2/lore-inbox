Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSIAGGs>; Sun, 1 Sep 2002 02:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSIAGGq>; Sun, 1 Sep 2002 02:06:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59583 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315483AbSIAGGq>;
	Sun, 1 Sep 2002 02:06:46 -0400
Date: Sat, 31 Aug 2002 23:04:51 -0700 (PDT)
Message-Id: <20020831.230451.35505734.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: fdavis@si.rr.com, linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: [PATCH] Re: 2.5.32 : net/ipv4/netfilter/ipfwadm_core.c compile
 error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0209011232410.14016-100000@blackbird.intercode.com.au>
References: <Pine.LNX.4.33.0208300801120.27846-100000@primetime>
	<Mutt.LNX.4.44.0209011232410.14016-100000@blackbird.intercode.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Sun, 1 Sep 2002 13:18:32 +1000 (EST)
   
   Please see the fix below.  (The problem only shows up when netfilter 
   debugging is enabled).

Applied to my tree, thanks.
