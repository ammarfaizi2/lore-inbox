Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTGOTKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTGOTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:10:31 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:56196 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S269557AbTGOTKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:10:25 -0400
Date: Wed, 16 Jul 2003 07:08:17 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: ANNOUNCE: Software Suspend for 2.4 kernel v1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058296097.1701.13.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been swallowed somewhere in the mailservers
yesterday, so I'm reposting....

---------

I'm delighted to announce the release of version 1.0 of Software Suspend
for the Linux 2.4 kernel.

Software Suspend is most easily described as the Linux equivalent of
Windows' hibernate functionality. It saves the contents of memory to
disk and powers down. When the computer is started up again, it reloads
the contents and the user can continue from where they left off. No
documents need to be reloaded or applications reopened and the process
is much faster than a normal shutdown and start up.

Software Suspend's features include:
- Cancel a suspend cycle (during suspending) by pressing escape
- Put an arbitrary limit on the size of the image saved
- Full debugging support (compile time option)
- Optional image compression
- Asynchronous I/O

Software Suspend doesn't yet include support for all hardware, and since
the 2.4 kernel lacks the driver model being developed for 2.5, other
hardware may require special handling. The Software Suspend website
(swsusp.sf.net) and mailing list (accessible via the web site) provide
support for dealing with these issues.

Thanks go to Florent Chabaud, Pavel Machek and Gabor Kuti, along with
many others who have tested and contributed to the development of
Software Suspend to this point.

======

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

