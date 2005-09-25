Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVIYDtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVIYDtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 23:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVIYDtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 23:49:39 -0400
Received: from zorg.st.net.au ([203.16.233.9]:4548 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751081AbVIYDti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 23:49:38 -0400
Message-ID: <43361E6D.8090908@torque.net>
Date: Sun, 25 Sep 2005 13:50:05 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Chris Wright <chrisw@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       Ingo Oeser <ioe-lkml@rameria.de>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jan Blunck <j.blunck@tu-harburg.de>
Subject: Re: [PATCH 6/7] [PATCH] sg.c: fix a memory leak in devices	seq_file
 implementation (2nd)
References: <20050826191755.052951000@localhost.localdomain>	 <20050826191942.444423000@localhost.localdomain> <1125109191.5079.157.camel@mulgrave>
In-Reply-To: <1125109191.5079.157.camel@mulgrave>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2005-08-26 at 12:18 -0700, Chris Wright wrote:
> 
>>plain text document attachment (fix-memory-leak-in-sg.c-
>>seq_file.patch)
>>-stable review patch.  If anyone has any  objections, please let us know.
> 
> 
> Looks fine to me.

James,
Please apply this patch, if you haven't already.

Signed-off-by: Douglas Gilbert <dougg@torque.net>

Doug Gilbert

