Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSICSFk>; Tue, 3 Sep 2002 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318860AbSICSFk>; Tue, 3 Sep 2002 14:05:40 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:5268 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318839AbSICSFj>;
	Tue, 3 Sep 2002 14:05:39 -0400
Message-ID: <3D74FAD9.5050108@colorfullife.com>
Date: Tue, 03 Sep 2002 20:09:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hirokazu Takahashi wrote:
> P.S.
>     Using "bswap" is little bit tricky.
> 

bswap was added with the 80486 - 80386 do not have that instruction, 
perhaps it's missing in some embedded system cpus, too. Is is possible 
to avoid it?

--
	Manfred


