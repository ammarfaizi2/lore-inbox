Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319114AbSHFOqi>; Tue, 6 Aug 2002 10:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319112AbSHFOqh>; Tue, 6 Aug 2002 10:46:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6862 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319114AbSHFOqg>;
	Tue, 6 Aug 2002 10:46:36 -0400
Date: Tue, 06 Aug 2002 07:37:36 -0700 (PDT)
Message-Id: <20020806.073736.90950306.davem@redhat.com>
To: imihaescu@hotpop.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel/User netlink socket is missing - help!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1028645091.3773.18.camel@rudolf>
References: <1028645091.3773.18.camel@rudolf>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Iulian Mihaescu <imihaescu@hotpop.com>
   Date: 06 Aug 2002 17:44:51 +0300
   
   Beginning with kernel-2.4.17, the option Kernel/User netlink socket 
   (CONFIG_NETLINK) is MISSING, and present is ONLY the second option:
   Netlink device emulation (CONFIG_NETLINK_DEV)

Because it is enabled all the time now, that is why the
option does not exist anymore.
