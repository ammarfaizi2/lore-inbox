Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbUADPJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUADPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:09:24 -0500
Received: from adsl-66-138-204-181.dsl.rcsntx.swbell.net ([66.138.204.181]:62197
	"EHLO mail.netschematics.com") by vger.kernel.org with ESMTP
	id S265707AbUADPJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:09:23 -0500
Message-ID: <3212.192.168.111.202.1073229389.squirrel@mail.linknet-solutions.com>
Date: Sun, 4 Jan 2004 09:16:29 -0600 (CST)
Subject: Bridge-nf code and CONFIG_NET_FASTROUTE
From: "Josh Berry" <josh.berry@linknet-solutions.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen several postings on this topic but they were all pretty old. 
Can the bridging-nf code be used if the CONFIG_NET_FASTROUTE option is
enabled in the kernel?

Will the firewalling functionality still work properly?  Does this
noticeably enhance performance?
