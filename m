Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSIEGe5>; Thu, 5 Sep 2002 02:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSIEGe5>; Thu, 5 Sep 2002 02:34:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4582 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317112AbSIEGe4>;
	Thu, 5 Sep 2002 02:34:56 -0400
Date: Wed, 04 Sep 2002 23:32:26 -0700 (PDT)
Message-Id: <20020904.233226.108195359.davem@redhat.com>
To: bof@bof.de
Cc: rusty@rustcorp.com.au, ak@suse.de, laforge@gnumonks.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_hash() problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905083340.E19551@oknodo.bof.de>
References: <20020905082128.D19551@oknodo.bof.de>
	<20020904.232425.10994370.davem@redhat.com>
	<20020905083340.E19551@oknodo.bof.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Schaaf <bof@bof.de>
   Date: Thu, 5 Sep 2002 08:33:40 +0200
   
   So, I don't see how your (abstractly true) observation is relevant, here.
   
So we waste 4 bytes in the kernel for really no reason?
A value we can compute in half a cycle?

