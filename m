Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbSKQT2q>; Sun, 17 Nov 2002 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267563AbSKQT2p>; Sun, 17 Nov 2002 14:28:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47078 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267560AbSKQT2p>;
	Sun, 17 Nov 2002 14:28:45 -0500
Date: Sun, 17 Nov 2002 11:33:19 -0800 (PST)
Message-Id: <20021117.113319.126503551.davem@redhat.com>
To: mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <467166910.1037370147@[10.10.2.3]>
References: <20021115.133004.65979948.davem@redhat.com>
	<467166910.1037370147@[10.10.2.3]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Fri, 15 Nov 2002 14:22:28 -0800
   
   OK, the easy way to fix this is to change the default owner for the
   category to someone else who can filter the bugs as they arrive in
   "OPEN" state. After filtering, they can be moved to "ASSIGNED" state,
   and the owner changed to you ... how does that sound?

This funnels the work to two people, it's still wildly inefficient.

What is so difficult about allowing anyone to review and close a bug?
