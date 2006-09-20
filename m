Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWITGpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWITGpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWITGpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:45:15 -0400
Received: from mx.astronics.com ([66.193.41.10]:35286 "EHLO lynx.astronics.com")
	by vger.kernel.org with ESMTP id S1750873AbWITGpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:45:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: best way to determine if a module is loaded - from another module
Date: Tue, 19 Sep 2006 23:45:13 -0700
Message-ID: <E3132DEC8AEA33489D1F1C89C1A3F8E702B8BB23@LYNX.gd-aes.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: best way to determine if a module is loaded - from another module
thread-index: AcbcgFLm4KsMlcBqT9OqWKaGfbrWww==
From: "Springer, Doug" <Doug.Springer@astronics.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on the replies -I'm not on the list.

I can't figure out how to know if another module is loaded.  I know
/proc/modules has the list.  Do I open that with sys_open or is there a
better way?

I have written a software watchdog for the amd au1200 cpu that will
gracefully shut the unit off if nobody kicks me.

I've read the kernel resources, and searched the mailing list but I
don't see an answer.

Thanks for any pointers to more info or how to do it.
