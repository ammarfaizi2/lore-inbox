Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRCaO30>; Sat, 31 Mar 2001 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRCaO3P>; Sat, 31 Mar 2001 09:29:15 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:44481 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S132402AbRCaO26>; Sat, 31 Mar 2001 09:28:58 -0500
Date: Sat, 31 Mar 2001 15:27:32 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: "Stephen E. Clark" <sclark46@gte.net>
cc: lk <linux-kernel@vger.kernel.org>
Subject: Re: MTRR on AMD THUNDERBIRD
In-Reply-To: <3AC5D65E.15E5142F@gte.net>
Message-ID: <Pine.LNX.4.31.0103311526300.16025-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2001, Stephen E. Clark wrote:

> Anyone know the status of mtrr the AMD Thunderbird? It does not seem to
> work for me anymore.
> reg00: base=0x00000000 (   0MB), size=16711936MB: write-back, count=1
> Linux version 2.4.2-ac18 (root@joker.seclark.com) (gcc version
                ^^^^^^^^^^

Fixed in 2.4.2-ac20 and higher.
Read Changelogs 8)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

