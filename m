Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286780AbRL1HWt>; Fri, 28 Dec 2001 02:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286778AbRL1HWj>; Fri, 28 Dec 2001 02:22:39 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:27555 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286780AbRL1HW3>; Fri, 28 Dec 2001 02:22:29 -0500
Date: Fri, 28 Dec 2001 09:21:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <srwalter@yahoo.com>
Subject: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <Pine.LNX.4.33.0112280918170.18421-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/sound is another tree in desperate need of
check_region/request_region cleanup. I'll try cover it and send to
the respective maintainers... Although i reckon the hit/miss ratio will be
a tad on the miss side ;)

Regards,
	Zwane Mwaikambo


