Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVGaPv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVGaPv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVGaPv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:51:57 -0400
Received: from mbox1.netikka.net ([213.250.81.202]:20117 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S261794AbVGaPv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:51:56 -0400
Message-ID: <1406.192.168.0.150.1122825115.squirrel@kone>
Date: Sun, 31 Jul 2005 18:51:55 +0300 (EEST)
Subject: Re: [git patches] new wireless stuffs
From: "Jar" <jar@pcuf.fi>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One big thing I'm still hoping for is that someone will merge HostAP
> (where ieee80211 code came from) with the ieee80211 generic code.

After the hostap driver is in, is there any reason to support the same hardware
(Prism2/2.5/3) via the orinoco driver also? Should the prism support to be removed
from the orinoco driver?

-- 
Best Regards, Jar
