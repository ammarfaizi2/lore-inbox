Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSKOHGx>; Fri, 15 Nov 2002 02:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKOHGw>; Fri, 15 Nov 2002 02:06:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265890AbSKOHGv>;
	Fri, 15 Nov 2002 02:06:51 -0500
Date: Thu, 14 Nov 2002 23:11:47 -0800 (PST)
Message-Id: <20021114.231147.22569665.davem@redhat.com>
To: mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <396026666.1037298946@[10.10.2.3]>
References: <1037325839.13735.4.camel@rth.ninka.net>
	<396026666.1037298946@[10.10.2.3]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Thu, 14 Nov 2002 18:35:47 -0800
   
   wouldn't you rather know of the breakage sooner rather
   than later?
   
It means I have to track multiple source trees, no thanks.
I have enough trouble keeping up with what is actually
in Linus's tree.

   Recall when some random idiot broke sparc64 by mucking with 
   free_area_init_node? Those changes had been sitting in -mm tree
   for a while ;-) (and yes, that was me).
   
When they get merged I'll deal with the carnage.
