Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUD1UcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUD1UcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUD1U3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:29:13 -0400
Received: from [81.219.144.6] ([81.219.144.6]:41990 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262050AbUD1U1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:27:49 -0400
Message-ID: <409013BD.5090900@pointblue.com.pl>
Date: Wed, 28 Apr 2004 21:27:41 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: IBM Lotus notes  5.0.X problem with 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I know there are quite few IBM ppl here.
I have problem, recently I moved our lotus notes (version 5) server 
from  kernel 2.2 to 2.6, along with hardware changes. But  it looks like 
it  crashes every now and again with:

-
04/28/2004 09:19:16 PM  Router: Message 006CCCD5 delivered to 
someone/somewhere
Fatal Error signal = 0x0000000b PID/TID = 624/2051
Freezing all server threads ...
-

No information in log files, nothing. I tried 2.6.6-rc3, 4kb stack, 8kb 
stack, gcc2-95, gcc 3.3, no difference.

It works fine with 2.4.26 thou.
Strange ? I don't know. From my perspective it shouldn't be kernel related.


One more thing, maybe someone knows where can I get incremental upgrade 
from lotus notes server version 5.0.5 for linux to current 5.0.x ? on 
IBM's webpages there is only 5.0.7->...->5.0.12.

--
GJ

