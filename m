Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSIAGGL>; Sun, 1 Sep 2002 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSIAGGL>; Sun, 1 Sep 2002 02:06:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58303 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315413AbSIAGGK>;
	Sun, 1 Sep 2002 02:06:10 -0400
Date: Sat, 31 Aug 2002 23:03:39 -0700 (PDT)
Message-Id: <20020831.230339.121297948.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6 compile fix, __FUNCTION__ pasting, 2.5.33
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0209011201440.13950-100000@blackbird.intercode.com.au>
References: <Mutt.LNX.4.44.0209011201440.13950-100000@blackbird.intercode.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Sun, 1 Sep 2002 12:05:13 +1000 (EST)

   Another __FUNCTION__ pasting fix, for 2.5.33.
   
Applied to my tree.
