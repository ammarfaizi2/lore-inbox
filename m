Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTHRNJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271820AbTHRNJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:09:47 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:39583 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S271823AbTHRNJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:09:46 -0400
Subject: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061212189.647.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Aug 2003 15:09:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

latest bk of 2.6.0-test3 hangs with these three lines:

ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.

And there it stays forever. 2.6.0-test3 worked like a charm. This is a
Asus CUV265-DLS motherboard. Dual P3.

Should I file a bugreport at bugzilla?

Best regards,
Stian

