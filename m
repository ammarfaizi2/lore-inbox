Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283041AbRK1Nla>; Wed, 28 Nov 2001 08:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283040AbRK1NlU>; Wed, 28 Nov 2001 08:41:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27796 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283036AbRK1NlP>;
	Wed, 28 Nov 2001 08:41:15 -0500
Date: Wed, 28 Nov 2001 05:41:12 -0800 (PST)
Message-Id: <20011128.054112.77872977.davem@redhat.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Magic Lantern
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1011128083018.10601A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011128083018.10601A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Wed, 28 Nov 2001 08:36:33 -0500 (EST)
   
   Yes, I know a module could be written, but I wonder if the
   capability already exists.

I'm pretty sure netfilter (at least at one point) allows
exactly what you describe.  Packet filters can be written
in userspace.
