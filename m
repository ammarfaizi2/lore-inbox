Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135780AbRAVXg5>; Mon, 22 Jan 2001 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135754AbRAVXgJ>; Mon, 22 Jan 2001 18:36:09 -0500
Received: from [209.209.13.26] ([209.209.13.26]:11279 "EHLO smile.idiom.com")
	by vger.kernel.org with ESMTP id <S135722AbRAVXfq>;
	Mon, 22 Jan 2001 18:35:46 -0500
Message-Id: <200101222335.PAA13078@echo.vennerable.com>
To: Glenn McGrath <bug1@optushome.com.au>
cc: Andrew Clausen <clausen@conectiva.com.br>, linux-fsdevel@vger.kernel.org,
        bug-parted@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM 
In-Reply-To: Message from Glenn McGrath <bug1@optushome.com.au> 
   of "Tue, 23 Jan 2001 09:16:49 +1100." <3A6CB151.875467B2@optushome.com.au> 
Date: Mon, 22 Jan 2001 15:35:11 -0800
From: Jason Venner <jason@vennerable.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bios on my laptop will only enable the suspend to disk function,
if there is a partion on the disk that is 'IBM Thinkpad hibernation'
(and it is a primary partition).

So, linux may not care but lots of other things that users rely on do
care.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
