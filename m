Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTF0Hw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTF0Hw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:52:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57267 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261769AbTF0Hwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:52:55 -0400
Date: Fri, 27 Jun 2003 01:00:59 -0700 (PDT)
Message-Id: <20030627.010059.68039169.davem@redhat.com>
To: matti.aarnio@zmailer.org
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030627075914.GO28900@mea-ext.zmailer.org>
References: <18330000.1056692768@[10.10.2.4]>
	<20030626.224739.88478624.davem@redhat.com>
	<20030627075914.GO28900@mea-ext.zmailer.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matti Aarnio <matti.aarnio@zmailer.org>
   Date: Fri, 27 Jun 2003 10:59:14 +0300

   The problem with "post to the list" is that sometimes things slip
   thru without anybody catching them.

It is not a problem, it is a feature.  What will happen is the
same thing that happens if Linus drops a patch.

It'll get retransmitted if the reporter cares about the
bug.  If he doesn't, the one of two things:

1) the bug actually isn't that important
2) it is important, and someone else will report the bug too

Therefore important issues tend to keep showing up, even if
they are not attended to the first time around.  This repeated
reporting and patch sending may seem like useless work, but this
is not true, it is actually a form of validation.

   I thought you don't need to login to see things in bugzilla ?

That's not the issue.  Asking people who want to help to
read a list or two, isn't much to ask.  Getting them to click
around some web site every day adds to the overhead.
