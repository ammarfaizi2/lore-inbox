Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTA3QoS>; Thu, 30 Jan 2003 11:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTA3QoS>; Thu, 30 Jan 2003 11:44:18 -0500
Received: from pcp01871097pcs.derbrn01.mi.comcast.net ([68.42.47.36]:51460
	"EHLO uncompiled.com") by vger.kernel.org with ESMTP
	id <S267515AbTA3QoR>; Thu, 30 Jan 2003 11:44:17 -0500
Subject: i810_audio problem fixed
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jan 2003 11:56:04 -0500
Message-Id: <1043945765.3248.5.camel@chandler>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A while back I sent a message describing bad skipping problems with the
i810_audio driver in 2.4. It turns out ACPI doesn't play nicely with the
i810_audio driver. I patched with the latest ACPI patch and it fixes the
skipping problem.

Thanks to Juergen Sawinski for helping me debug this. 


Regards,

Matthew J. Fanto



