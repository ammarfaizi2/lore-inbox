Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAQJfg>; Wed, 17 Jan 2001 04:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbRAQJf0>; Wed, 17 Jan 2001 04:35:26 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:30214 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130153AbRAQJfV>; Wed, 17 Jan 2001 04:35:21 -0500
Message-ID: <3A656749.ACF3F01A@t-online.de>
Date: Wed, 17 Jan 2001 10:35:05 +0100
From: Jeffrey.Rose@t-online.de (Jeffrey Rose)
Organization: http://ChristForge.SourceForge.net/
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 config breaks /dev/fd0* major/minor ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings hard working coders,

I recently installed 2.4.0 on a RH 7 box, replacing the stock RH
kernel-hack that came with the CD distro.

All is well, however, I get a wrong major/minor reported when attempting
to mount /dev/fd0 ... I have tried all the fd0* related to a 1.44 disk
in /dev with same message. The default major,minor for my /dev/fd0 is
2,0 (worked before upgrade).

I apologize in advance for submitting his to the kernel list, but if
anyone has a moment to step away from chronic
kernel-hacking-frustration-syndrom ... I would appreciate I tip as to
what and how I may have broken something in my 2.4.0 config and how to
regain access to my floppy drive.

Sincerely thankful,

Jeff
-- 
<Jeffrey.Rose@t-online.de>
KEYSERVER=wwwkeys.de.pgp.net
SEARCH STRING=Jeffrey Rose
KEYID=6AD04244
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
