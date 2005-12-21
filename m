Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVLUHSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVLUHSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVLUHSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:18:34 -0500
Received: from 8.ctyme.com ([69.50.231.8]:21121 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932300AbVLUHSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:18:33 -0500
Message-ID: <43A901C8.4090706@perkel.com>
Date: Tue, 20 Dec 2005 23:18:32 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA SCSI device numbering - I'm confuzed! - Help!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - this really has me stumped. I have a asus A8N-SLI premium 
motherboard. It has 4 SATA ports on it. The ports are numbered 1 to 4. 
So somehow I asumed that port 1 would be /dev/sda ... port 4 would be 
/dev/sdd - but when I boot up the order is very different and doesn't 
make a lot of sense. How can a person predict what drives will get what 
device names. Sure would be handy to be able to know that.

HELP!

Thanks in advance. My server is down - struggling with this issue.


