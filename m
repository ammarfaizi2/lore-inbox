Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUGHGuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUGHGuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUGHGuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:50:20 -0400
Received: from web41113.mail.yahoo.com ([66.218.93.29]:20265 "HELO
	web41113.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265811AbUGHGuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:50:16 -0400
Message-ID: <20040708065016.81889.qmail@web41113.mail.yahoo.com>
Date: Wed, 7 Jul 2004 23:50:16 -0700 (PDT)
From: Naveen Kumar <naveenkrg@yahoo.com>
Subject: Adding multicast routes using Netlink sockets
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to check if you can add multicast routes
to kernel using netlink sockets in a way similar to
unicast routes. As netlink sockets can be used to add
unicast routes to FIB, can you add multicast routes to
Multicast Forwarding Cache so that kernel can support
Multicast Forwarding?

 If this is possible, how would you go about giving
options to the netlink sockets?

Please inform me by CCing your answers/suggestions to
me.

Thanks,
Naveen.


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
