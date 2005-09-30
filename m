Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVI3UQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVI3UQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVI3UQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:16:13 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39404 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030383AbVI3UQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:16:12 -0400
Date: Fri, 30 Sep 2005 22:15:35 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Karall <dominik.karall@gmx.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.14-rc2-mm2 (PHY reset until link up)
Message-ID: <20050930201535.GB24548@electric-eye.fr.zoreil.com>
References: <20050929143732.59d22569.akpm@osdl.org> <200509302049.45143.dominik.karall@gmx.net> <20050930120723.07d42517.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930120723.07d42517.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
[...]
> That seems a bit dumb - R8169_MSG_DEFAULT has NETIF_MSG_LINK enabled, so
> yes, that driver's going to spam logs when there's no cable connected.

There is no cable and the deviced has been ifconfiged up. My fridge always
lights up when I open the door. It does not care if it's night or not.

Mmmm... It could be a bit dumb after all.

--
Ueimor
