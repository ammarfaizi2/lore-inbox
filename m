Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276379AbRI2ARR>; Fri, 28 Sep 2001 20:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276380AbRI2ARG>; Fri, 28 Sep 2001 20:17:06 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:9744 "EHLO mx7.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S276379AbRI2AQu>;
	Fri, 28 Sep 2001 20:16:50 -0400
Date: Sat, 29 Sep 2001 08:18:49 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
In-Reply-To: <Pine.LNX.4.40.0109280920360.19506-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.33.0109290816480.10053-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/29/2001
 08:17:10 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/29/2001
 08:17:13 AM,
	Serialize complete at 09/29/2001 08:17:13 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, David Lang wrote:

> ?? slackware 8 has large file support (I've been useing it for a while
> now)
>

I think you can get >2GB support if you've Gcc 3.0. Even with the latest
kernel 2.4.x, you won't get >2GB with gcc 2.95.3.


Jeff.

