Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbSJGMCP>; Mon, 7 Oct 2002 08:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbSJGMCP>; Mon, 7 Oct 2002 08:02:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30360 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262999AbSJGMBX>;
	Mon, 7 Oct 2002 08:01:23 -0400
Date: Mon, 07 Oct 2002 05:00:13 -0700 (PDT)
Message-Id: <20021007.050013.81468898.davem@redhat.com>
To: root@chaos.analogic.com
Cc: giduru@yahoo.com, hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1021007075423.18528A-100000@chaos.analogic.com>
References: <20021007053805.95762.qmail@web13204.mail.yahoo.com>
	<Pine.LNX.3.95.1021007075423.18528A-100000@chaos.analogic.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Mon, 7 Oct 2002 08:04:06 -0400 (EDT)
   
   We use 2.4.18 on embedded systems. 2.4.19 has some new
   problems (The reported select() on network I/O, being
   one of them).

Could you report this bug to linux-net and netdev?
