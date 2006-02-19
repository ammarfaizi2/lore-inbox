Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWBSTLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWBSTLS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBSTLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:11:18 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:26510 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932222AbWBSTLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:11:17 -0500
Message-ID: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
Date: Sun, 19 Feb 2006 14:11:17 -0500 (EST)
Subject: kernel panic with unloadable module support... SMP
From: "George P Nychis" <gnychis@cmu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Whenever I compiled unloadable module support into my 2.6.15-r1 kernel, my kernel panic's when booting up when it tries to load a module for the first time.

I had this problem back with the 2.6.14 kernel, but figured it may have been solved since then so I tried it... and still fails.

Unloadable module support would be very helpful to me.

I am using an intel p4 3.0ghz with SMP support built into the kernel.

Please CC me in your responses.

Thanks!
George

