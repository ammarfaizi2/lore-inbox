Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKSRlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKSRlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 12:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKSRlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 12:41:23 -0500
Received: from 8.ctyme.com ([69.50.231.8]:17854 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1750726AbVKSRlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 12:41:22 -0500
Message-ID: <437F63C1.6010507@perkel.com>
Date: Sat, 19 Nov 2005 09:41:21 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Does Linux support powering down SATA drives?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to save power consumption. I have a backup drive that is used 
only once a day to back up the main drive. So - why should I run it more 
that 10 minutes a day? What I'd like to do is keep it in an off state 
and then at night power it on, mount it up, do the backup, unmount it, 
and shut it down. Can I do that?

