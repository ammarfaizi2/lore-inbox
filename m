Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLCVan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTLCVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:30:43 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:61377 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261825AbTLCVad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:30:33 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2003 13:31:54 -0800
MIME-Version: 1.0
Subject: Linux GPL and binary module exception clause?
Message-ID: <3FCDE5CA.2543.3E4EE6AA@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have heard many people reference the fact that the although the Linux 
Kernel is under the GNU GPL license, that the code is licensed with an 
exception clause that says binary loadable modules do not have to be 
under the GPL. Obviously today there are vendors delivering binary 
modules (not supported by the kernel maintainers of course), so clearly 
people believe this to be true. However I was curious about the wording 
of this exception clause so I went looking for it, but I cannot seem to 
find it. I downloaded the 2.6-test1 kernel source code and looked at the 
COPYING file, but found nothing relating to this (just the note at the 
top from Linus saying user programs are not covered by the GPL). I also 
looked in the README file and nothing was mentioned there either, at 
least from what I could see from a quick read.

So does this exception clause exist or not? If not, how can the binary 
modules be valid for use under Linux if the source is not made available 
under the terms of the GNU GPL?

Lastly I noticed that the few source code modules I looked at to see if 
the exception clause was mentioned there, did not contain the usual GNU 
GPL preable section at the top of each file. IMHO all files need to have 
such a notice attached, or they are not under the GNU GPL (just being in 
a ZIP/tar achive with a COPYING file does not place a file under the GNU 
GPL). Given all the current legal stuff going on with SCO, I figured 
every file would have such a header. In fact some of the files I looked 
at didn't even contain a basic copyright notice!!

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

