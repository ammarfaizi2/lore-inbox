Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTFDJ3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFDJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:29:04 -0400
Received: from [196.15.199.73] ([196.15.199.73]:64274 "EHLO
	smtpin.safmarine.co.za") by vger.kernel.org with ESMTP
	id S261322AbTFDJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:28:57 -0400
Subject: partitioning problem
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OFF3C266B7.2A2446E1-ON42256D3B.0034FC6D-42256D3B.0035BD0C@safmarine.co.za>
From: jmutonho@za.safmarine.com
Date: Wed, 4 Jun 2003 11:42:25 +0200
X-MIMETrack: Serialize by Router on CPTMTA02/Linernet(Release 5.0.10 |March 22, 2002) at
 06/04/2003 11:43:55 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
This is NOT really a kernel problem but you guys might understand it
better.

I'm installing Redhat 9 on my pc which has a Seagate(ST340016)  hard
drive(30G).The machine is currently running Win2K  and had two
partitions C and D  (before repartitioning).The D drive is a logical
one and it's the one I split into two and made space for Linux.During
the installation I allocated space for the swap and  the rest of the
required stuff(/boot, / , /usr  etc) .I made it through to selecting
the packages I want installed and just after that , when Anaconda
tries to initialize the swap space , I get an error message saying
"Attempt to read sector 0-7 outside of partition on /dev/hda".
Now /dev/hda is actually the Win2K partition.It also says something
to the effect that there is a problem reading the partition table.I
clicked on "Ignore" (on the pop up) and I get another  message
telling me that the problem is a serious one and installation cannot
continue.
Whats happening ?

JeffM


