Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTLBUin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTLBUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:37:56 -0500
Received: from web41201.mail.yahoo.com ([66.218.93.34]:27737 "HELO
	web41201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264377AbTLBUgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:36:50 -0500
Message-ID: <20031202203648.64084.qmail@web41201.mail.yahoo.com>
Date: Tue, 2 Dec 2003 12:36:48 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [2.6.0-test11]: It doesn't boot with a bootcd
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to build a bootcd with 2.6.0-test11 but it doesn't boot either
with framebuffer or without framebuffer. I also tried 2.6.0-testX-mm[1,2] but
same problems. I could make it work on test6 with no framebuffer once. But
test7 to test11 never worked. My bootcd works fine with 2.4.20. I upgraded
bin-utils, linux-utils, other tools and  libraries to use 2.6.0 following the
Documentation/Changes file. My kernel config file is nothing special. It is
based on 2.4.20 and added few things like XFS. I used to see Oops crashes but I
don't see those any more but it stops in middle of booting and hangs. If any
bootcd builders are out there and have any experiences on 2.6.0-testx, please
let me know. Thanks in advance!

Jin


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
