Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbTLWNJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLWNJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:09:25 -0500
Received: from mx11.sac.fedex.com ([199.81.193.118]:19461 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S265130AbTLWNJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:09:24 -0500
Date: Tue, 23 Dec 2003 21:07:45 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [bug] 2.6.0 COMMAND_LINE_SIZE <160???
Message-ID: <Pine.LNX.4.58.0312232102340.5732@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/23/2003
 09:09:19 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/23/2003
 09:09:22 PM,
	Serialize complete at 12/23/2003 09:09:22 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't seems to pass more than 160 bytes on command line when booting
linux-2.6.0. 2.4.24 is ok.

Booting via loadlin, but I've tried linld, still the same problem.

It hangs after "Ok, booting the kernel".

Thanks,
Jeff
[ jchua@fedex.com ]

