Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTF0FlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 01:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTF0FlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 01:41:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:435 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263859AbTF0Fjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 01:39:32 -0400
Date: Thu, 26 Jun 2003 22:47:39 -0700 (PDT)
Message-Id: <20030626.224739.88478624.davem@redhat.com>
To: mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <18330000.1056692768@[10.10.2.4]>
References: <20030626.223002.21926109.davem@redhat.com>
	<18330000.1056692768@[10.10.2.4]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Thu, 26 Jun 2003 22:46:10 -0700
   
   If people choose to file bugs in bugzilla as well, they'll still be
   processed by someone.

Just so that someone can post them to the lists?
That sounds like a completely silly way to operate.

I'd rather they get posted to the lists _ONLY_.

This way not that "someone", but "everyone" on the lists
can participate and contribute to responding to the bug.

The only way you can make things scale is if you throw a group
of people into the collective of folks able to respond to a problem.

If it all gets filtered through by one guy, THAT DOES NOT WORK.
That one guy limits what can be done, and when he's busy one day
or he goes away on vacation for a while, the whole assembly
line stops.

Therefore, please eliminate the networking category on bugme.osdl.org
and we'll process bug reports on the lists so that not _ONE_ but the
whole community of networking developers can look at the bug.
