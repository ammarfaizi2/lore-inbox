Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVAaIXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVAaIXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVAaIXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:23:39 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:42638 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S261858AbVAaIXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:23:24 -0500
Message-ID: <41FDEB6B.6090209@persistent.co.in>
Date: Mon, 31 Jan 2005 13:55:15 +0530
From: Sumesh <sumesh_kumar@persistent.co.in>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ych43 <ych43@student.canterbury.ac.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: where can I find the values of a file descriptor in Linux?
References: <41F40C43@webmail>
In-Reply-To: <41F40C43@webmail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do a "man 2 stat" n u shall see the "struct stat" usage.

Regards,
Sumesh



ych43 wrote:

>Hey,
>  Does anybody know how to find the specific information included in the file 
>descriptor in Linux. When a file is created, the file manager creates a file 
>descriptor, in which it stores detailed information about the file. But I do 
>not know where I can find this detailed information? Does command ls -l 
>display all the information included in the file descriptor.
>  Does anybody can help me?
>  Thanks in advance
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
