Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWHGGSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWHGGSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWHGGSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:18:55 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:13492 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751104AbWHGGSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:18:54 -0400
Date: Mon, 7 Aug 2006 08:17:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avinash Ramanath <avinashr@gmail.com>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Stat in kernel space
In-Reply-To: <abcd72470608061820r4c313ebbw80e7cab98d5d2299@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608070817330.31761@yvahk01.tjqt.qr>
References: <abcd72470608061746o2810f895n9f9979f99c00d273@mail.gmail.com>
 <abcd72470608061820r4c313ebbw80e7cab98d5d2299@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I wanted to know the file-size using stat.

inode->i_size

>
> On 8/6/06, Avinash Ramanath <avinashr@gmail.com> wrote:
>> Could somebody let me know which function equivalent/header file is
>> available in kernel space for "stat"ing?
>> I want an equivalent of stat/lstat/fstat in kernel space.
>> 
>> Thanks,
>> Avinash.
>> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Jan Engelhardt
-- 
