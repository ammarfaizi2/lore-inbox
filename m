Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263238AbVGOIFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbVGOIFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263237AbVGOIFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:05:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17328 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261865AbVGOIFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:05:48 -0400
Date: Fri, 15 Jul 2005 10:05:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Elias Kesh <linux@kesh.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RealTimeSync Patch
In-Reply-To: <42D69154.6040608@kesh.com>
Message-ID: <Pine.LNX.4.61.0507151003050.20435@yvahk01.tjqt.qr>
References: <42D69154.6040608@kesh.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>http://tree.celinuxforum.org/CelfPubWiki/RTCNoSync

The webpage says...

>One tradeoff in making this modification is that the time stored by the Linux
>kernel is no longer completely synchronized

If one runs "hwclock", the delta is barely 0.000, but always some more or some 
less, so it should not matter.



Jan Engelhardt
-- 
