Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbUDBJ7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUDBJ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:58:59 -0500
Received: from web41408.mail.yahoo.com ([66.218.93.74]:64951 "HELO
	web41408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263430AbUDBJ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:58:58 -0500
Message-ID: <20040402095858.15319.qmail@web41408.mail.yahoo.com>
Date: Fri, 2 Apr 2004 01:58:58 -0800 (PST)
From: Parag Nemade <cranium2003@yahoo.com>
Subject: kernel development netwrok protocol modification
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello friends,
            I want to add my own routine to network
protocol stack. 
What i want to do i will explain you. For each and
every packet that outgoes from kernel i want to attach
a 8 byte of my own checksum to data part in packet.
This ensures that data is to be transmitted correctly
across computers.
Can anybody help me where i have to insert my code in
kernel source tree cause there are 3 programs to be
included in which one exchanges keys adjecent
computers. second calculates checksum on basis of that
key. and third checks packet replay. 
I wish to be personally CC'ed the answers/comments
posted to the list in response to my posting.

regards,
Parag.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
