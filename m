Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273190AbRIJEQd>; Mon, 10 Sep 2001 00:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273192AbRIJEQY>; Mon, 10 Sep 2001 00:16:24 -0400
Received: from [209.202.108.240] ([209.202.108.240]:774 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S273190AbRIJEQT>; Mon, 10 Sep 2001 00:16:19 -0400
Date: Mon, 10 Sep 2001 00:16:25 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
In-Reply-To: <Pine.LNX.4.33.0109092023230.11787-100000@terbidium.openservices.net>
Message-ID: <Pine.LNX.4.33.0109100015360.22080-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:

> On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:
>
> I have solved the problem. It had to do with the setting of
> CONFIG_APM_REAL_MODE_POWER_OFF. It has to be on in my case.
>
> Is there any time when this option _has_ to be off?

Sigh. I apologize. This did _not_ work. Does anyone else have any hoops for me
to jump through?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

