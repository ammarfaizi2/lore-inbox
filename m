Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTLSO6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 09:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTLSO6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 09:58:32 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:3747 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263376AbTLSO6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 09:58:30 -0500
Message-ID: <3FE31212.3020701@cyberone.com.au>
Date: Sat, 20 Dec 2003 01:58:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] sched domains w27 for 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/w27/

This patch includes a lot of fixes, especially to the active balancing
and HT code. It also addresses Rusty's suggestions, and will hopefully fix
Zwane's interactivity problems. Testing, comments welcome.

Nick


