Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273071AbTG3RV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273072AbTG3RV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:21:56 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:10373 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S273071AbTG3RVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:21:54 -0400
Subject: Buffer I/O error on device hde3, logical block 4429
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059585712.11341.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 12:21:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.0-test2-mm1, and upon boot have received a gift of many
"Buffer I/O error on device hde3" messages in my log. After they quit,
they never seem to come back.

I'd just like to know what might cause this? I see fs/buffer.c is
telling me this, but I don't know what is failing.

One thing of note, I just upgraded my CPU from an Athlon XP 1800+ to a
2400+, and had to disable IO-APIC, and shut APIC off in my BIOS.

My hardware: http://www.enodev.com/info.html
(If I should include more info let me know)
