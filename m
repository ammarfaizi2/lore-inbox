Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUBKSme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUBKSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:42:34 -0500
Received: from may.nosdns.com ([207.44.240.96]:34791 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S266048AbUBKSmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:42:32 -0500
Date: Wed, 11 Feb 2004 11:43:51 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <882539071.20040211114351@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.2 Kernel Problem
In-Reply-To: <20040211111800.A5618@home.com>
References: <20040211061753.GA22167@plexity.net>
 <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
 <20040211111800.A5618@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

   I noticed two problems that seems to come up after using the 2.6.2 kernel on the production servers.  One is the RPM system. It seems to barf badly due to the db3 vs db4 errors when updating the packages on Redhat 9.0 system.

   Second one is little more weirder.  It is with Horde system which it works all the way, except for sending emails, which it seems to have some problem with it.

   Both works fine under 2.4 kernels, but after switching to 2.6, it seems to have certain problems with it.  Any ideas on this?


-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

