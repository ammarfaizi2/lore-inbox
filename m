Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTEAOvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTEAOvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:51:13 -0400
Received: from mbox1.netikka.net ([213.250.81.202]:17575 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S261360AbTEAOvK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:51:10 -0400
From: Thomas Backlund <tmb@iki.fi>
To: "O.Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Thu, 1 May 2003 18:03:22 +0300
User-Agent: KMail/1.5.1
References: <3EB12D42.4010502@superonline.com>
In-Reply-To: <3EB12D42.4010502@superonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305011803.22048.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viestissä Torstai 1. Toukokuuta 2003 17:20, O.Sezer kirjoitti:
> Thomas Backlund wrote:
>
> [SNIPPED]
>
>  > So this way we wont break current systems,
>  > but have an option for those cards that has problem...
>  > (seems to be AGP + >=128MB VideoRAM + >=1024MB system RAM only)
>
> AGP			-> Yes
>
>  >= 128MB RAM		-> Yes
>  >=1024MB system RAM	-> _ NO _.  Only 256MB
>
Now thats new to me...
all reports I've seen earlier has been with 1024MB or more...
Oh well... every day you learn something new...

> > (OK, I added another 128 today, so it's 384 now :))
>
> Regards;
> Özkan Sezer

-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

