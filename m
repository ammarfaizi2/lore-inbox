Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSHEFni>; Mon, 5 Aug 2002 01:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSHEFni>; Mon, 5 Aug 2002 01:43:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18879 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318317AbSHEFnh>;
	Mon, 5 Aug 2002 01:43:37 -0400
Date: Sun, 04 Aug 2002 22:34:47 -0700 (PDT)
Message-Id: <20020804.223447.05930294.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020805041904.783374450@lists.samba.org>
References: <20020801.191449.101696880.davem@redhat.com>
	<20020805041904.783374450@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 05 Aug 2002 14:14:12 +1000

   In message <20020801.191449.101696880.davem@redhat.com> you write:
   > A nice enhancement would be to move the kprobe table and
   > other generic bits into a common area so that it did not
   > need to be duplicated as other arches add kprobe support.
   
   Done.  Look better?

That's exactly how I wanted the generic stuff split out,
it's perfect.
