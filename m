Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTIAR6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbTIAR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:58:13 -0400
Received: from main.gmane.org ([80.91.224.249]:32969 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263220AbTIAR6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:58:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: raid1 error while rewind tape
Date: Mon, 01 Sep 2003 13:58:12 -0400
Message-ID: <3F5388B4.6050205@ghz.cc>
References: <bivvbr$53i$1@ulysses.news.tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <bivvbr$53i$1@ulysses.news.tiscali.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Jakobsmeier wrote:

> While i let the system rewind the tape, and if this command needs long
> time, the scsi driver from kernel recogizes an error.

You might want to check the FAQs for info on "SCSI disconnect" support. 
Most modern SCSI tape drives support this, but without any configuration 
details on the tape drive or the host adapter, it's hard to say whether 
it will work for you.

Chances are that more people will have answers on one of the 
SCSI-specific lists.

-C


