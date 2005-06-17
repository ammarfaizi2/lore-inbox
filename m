Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVFQPhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVFQPhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVFQPhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:37:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3231 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261998AbVFQPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:37:36 -0400
Message-ID: <42B2EE31.9060709@nortel.com>
Date: Fri, 17 Jun 2005 09:37:21 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net>	 <1118946334.3949.63.camel@betsy>  <42B227B5.3090509@yahoo.com.au>	 <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy>
In-Reply-To: <1119021336.3949.104.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of inotify improvements...

On a newsgroup someone was using inotify, but was asking if there was 
any way to also determine which process/user had caused the notification.

Is this something that would make sense (as an optional bit of 
information) in inotify?

Chris
