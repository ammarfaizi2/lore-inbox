Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAER07>; Fri, 5 Jan 2001 12:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRAER0t>; Fri, 5 Jan 2001 12:26:49 -0500
Received: from msgrouter1.onetel.net.uk ([212.67.96.140]:54640 "EHLO
	msgrouter1.onetel.net.uk") by vger.kernel.org with ESMTP
	id <S129436AbRAER0a>; Fri, 5 Jan 2001 12:26:30 -0500
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramieleavitt@onetel.net.uk>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4 Kernel Lockup
Date: Fri, 5 Jan 2001 17:29:33 -0000
Message-ID: <JKEGJJAJPOLNIFPAEDHLAEJNCCAA.laramieleavitt@onetel.net.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I seem to be getting a rather odd kernel lockup on 2.4.
I am using XFree 3.3.6 ( I believe ).

Whenever I start X, my session starts up like normal,
but soon locks HARD.  Is this a known issue?  I 
suspected the fb stuff, and so I removed it and the 
problem remains.

Any ideas?  I can repeat it every single time.

Laramie


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
