Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbTFNHiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTFNHiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:38:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18603 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265623AbTFNHiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:38:15 -0400
Message-ID: <3EEAD41B.2090709@us.ibm.com>
Date: Sat, 14 Jun 2003 00:51:55 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
References: <20030613013337.1a6789d9.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm9/
> 
> 
> Lots of fixes, lots of new things.
>

Good news, Andrew. I run 50 fsx tests on ext3 filesystems on 2.5.70-mm9. 
   The hang problem I used seen on 2.5.70-mm6 kernel is gone. The tests 
runs fine for more than 9 hours. (Normally the problem will occur after 
7 hours run on 2.5.70-mm6 kernel).

I am running the tests on 8 way PIII 700MHz, 4G memory, with 
elevator=deadline.


