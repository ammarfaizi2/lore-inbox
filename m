Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGSHsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGSHsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 03:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUGSHsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 03:48:31 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:7847 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264781AbUGSHsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 03:48:30 -0400
Message-ID: <40FB7CC9.4060302@yahoo.com.au>
Date: Mon, 19 Jul 2004 17:48:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: rsync out of memory 2.6.8-rc2
References: <20040718215201.GA840@xeon2.local.here>
In-Reply-To: <20040718215201.GA840@xeon2.local.here>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:
> rsync-2.6.2 of a large disc using 2.6.8-rc2 (I also tried 2.6.7-bk14)
> stops with "kernel: Out of Memory: Killed process xxxx" messages
> during filelist gathering.
> 
> When this happens only 1.4 GB out of 2 GB RAM and no swap is used.
> 
> No problems with kernel 2.6.7.
> (Peak RAM usage during filelist gathering was 1.8 GB, no swap)
> 

Hi Klaus,
What arguments are you running rsync with? Also, how many files, and
how large are they?

Thanks
Nick
