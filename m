Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSJCNzQ>; Thu, 3 Oct 2002 09:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJCNzQ>; Thu, 3 Oct 2002 09:55:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28882 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261462AbSJCNzP>;
	Thu, 3 Oct 2002 09:55:15 -0400
Date: Thu, 03 Oct 2002 06:53:33 -0700 (PDT)
Message-Id: <20021003.065333.62355807.davem@redhat.com>
To: linux_4ever@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003135756.88786.qmail@web9601.mail.yahoo.com>
References: <20021003.063256.84377325.davem@redhat.com>
	<20021003135756.88786.qmail@web9601.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve G <linux_4ever@yahoo.com>
   Date: Thu, 3 Oct 2002 06:57:56 -0700 (PDT)

   >then every one of those ipv6 options you change 
   >which are being used by userspace breaks.
   
   I guess you're right. Smaller patch attached.
   
Still broken, you left IPV6_ADDRFORM in the header file.

Anyways, I'll take care of this myself and you can come back
with ipv6 contributions when NASA fixes their internal email
policy or you get a real ISP for linux kernel postings. :-)

