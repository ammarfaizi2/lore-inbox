Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTFPP5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTFPP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:57:06 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:18058 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S263990AbTFPP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:57:05 -0400
Message-ID: <3EEDEC56.8090802@sixbit.org>
Date: Mon, 16 Jun 2003 12:12:06 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Frank <mflt1@micrologica.com.hk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
References: <20030616061004$261e@gated-at.bofh.it> <20030616073013$5824@gated-at.bofh.it> <20030616110017$7e46@gated-at.bofh.it>
In-Reply-To: <20030616110017$7e46@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:
>
>>Could you check whether plain 2.5.71 (or 2.5.71-bkcurr) works?
> 
> 
> 2.5.71 had a compile problem - posted seperately
> see 2.5.71 net/built-in.o : undefined reference to `register_cpu_notifier'

This has been fixed in the bk snapshots, so use 2.5.71-bkX.


