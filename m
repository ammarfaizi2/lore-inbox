Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289675AbSAOVZA>; Tue, 15 Jan 2002 16:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289680AbSAOVYm>; Tue, 15 Jan 2002 16:24:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2983 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289675AbSAOVYU>;
	Tue, 15 Jan 2002 16:24:20 -0500
Date: Tue, 15 Jan 2002 13:21:32 -0800 (PST)
Message-Id: <20020115.132132.62388900.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: how to do DIVERT socket equivalent with netfilter?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C449CE3.FBA52C68@nortelnetworks.com>
In-Reply-To: <3C449CE3.FBA52C68@nortelnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Friesen <cfriesen@nortelnetworks.com>
   Date: Tue, 15 Jan 2002 16:19:31 -0500
   
   Now we're looking to make the thing work on 2.4.  Unfortunately, it doesn't look
   like DIVERT sockets are supported in 2.4

Umm... linux/net/core/dv.c implement the divert stuff just like
the 2.2.x copy does?

Franks a lot,
David S. Miller
davem@redhat.com
