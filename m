Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUG0SCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUG0SCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUG0SCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:02:19 -0400
Received: from [195.199.63.65] ([195.199.63.65]:51879 "EHLO cinke.fazekas.hu")
	by vger.kernel.org with ESMTP id S266496AbUG0SCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:02:12 -0400
Date: Tue, 27 Jul 2004 20:01:57 +0200 (CEST)
From: Balint Marton <cus@fazekas.hu>
To: "Eble, Dan" <DanE@aiinet.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: RE: [PATCH] get_random_bytes returns the same on every boot
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFC2F@aiexchange.ai.aiinet.com>
Message-ID: <Pine.LNX.4.58.0407271951590.23550@cinke.fazekas.hu>
References: <C0170D0AF1277849A4B4518034F855DD0CFC2F@aiexchange.ai.aiinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

In my previous email, i wrote about a 40 computer test.
Today, I repeated my test, and although every computer got the right IP 
address, there were at least 7 lines of DHCPNAK in the dhcpd logfile.
So the system time alone is not as good as it looked like.

Cus
