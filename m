Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTIUBgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 21:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTIUBgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 21:36:04 -0400
Received: from dyn-ctb-210-9-243-218.webone.com.au ([210.9.243.218]:34820 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262060AbTIUBgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 21:36:02 -0400
Message-ID: <3F6D0075.1000707@cyberone.com.au>
Date: Sun, 21 Sep 2003 11:35:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rene Rask <rene@grain.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
References: <1064055732.5913.15.camel@animatrix.klippegang.dk>
In-Reply-To: <1064055732.5913.15.camel@animatrix.klippegang.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rene Rask wrote:

>I'm not subscribed to the list so please cc me if you have questions.
>
>
>>Try disabling TCQ, I don't think it is very stable for IDE drives.
>>
>
>I'm getting these messages with a 3ware 7500-12 card as well even though
>it is a scsi card.
>I'm using kernel 2.6-test5-bk6 and copying files files an nfs mount to
>the local 3ware disks ( 6 200 GB disks in hardware RAID5).
>

No hangs though?


