Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJQMXO>; Thu, 17 Oct 2002 08:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJQMXO>; Thu, 17 Oct 2002 08:23:14 -0400
Received: from iris.mc.com ([192.233.16.119]:4286 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S261573AbSJQMXN>;
	Thu, 17 Oct 2002 08:23:13 -0400
Message-Id: <200210171229.IAA22940@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: linux-kernel@vger.kernel.org
Subject: George Anzinger's high res timers and posix timers
Date: Thu, 17 Oct 2002 08:34:55 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus (marcello too),

	please please please please apply George's patches.

	increasing HZ to 1000 is a painful hack that hurts us all in excange for a 
very small benefit to a very limited set of services.

	George's solution provides high res timers for those services and users that 
want it without penalizing those who don't.

	please please please.

	if nothing else, put it in with default config to off.
 
--	Mark Salisbury
	
