Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbRGKFEz>; Wed, 11 Jul 2001 01:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267205AbRGKFEe>; Wed, 11 Jul 2001 01:04:34 -0400
Received: from geos.coastside.net ([207.213.212.4]:64713 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267204AbRGKFE0>; Wed, 11 Jul 2001 01:04:26 -0400
Mime-Version: 1.0
Message-Id: <p05100359b7718e82d645@[207.213.214.37]>
In-Reply-To: <9igljq$nlu$1@cesium.transmeta.com>
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com>
 <9igkjl$nk1$1@cesium.transmeta.com>
 <p05100358b771879535bc@[207.213.214.37]>
 <9igljq$nlu$1@cesium.transmeta.com>
Date: Tue, 10 Jul 2001 22:04:17 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:44 PM -0700 2001-07-10, H. Peter Anvin wrote:
>  > Level 3 is the Intel's CPU serial number "feature". Didn't Intel back
>>  off on that? Maybe that has something to do with it, and perhaps the
>>  utility is doing the cooking.
>>
>
>Actually, the kernel kills it if it detects it.

Not unconditionally, though. And (to the original question), it's not 
clear why two CPUs would be treated differently.
-- 
/Jonathan Lundell.
