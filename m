Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSE2QbG>; Wed, 29 May 2002 12:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSE2QbF>; Wed, 29 May 2002 12:31:05 -0400
Received: from faraday.ee.utt.ro ([193.226.10.1]:15375 "EHLO faraday.ee.utt.ro")
	by vger.kernel.org with ESMTP id <S313508AbSE2QbF>;
	Wed, 29 May 2002 12:31:05 -0400
Date: Wed, 29 May 2002 19:30:30 +0300 (EEST)
From: Sebastian Szonyi <sony@faraday.ee.utt.ro>
To: Georgi Chorbadzhiyski <gf@unixsol.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 oopses (filesystem related)
In-Reply-To: <3CF4DDEE.5070704@unixsol.org>
Message-ID: <Pine.LNX.4.33.0205291928100.27120-100000@faraday.ee.utt.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 May 2002, Georgi Chorbadzhiyski wrote:

> Adding Swap: 265064k swap-space (priority -1)
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> kjournald starting.  Commit interval 5 seconds


running e2fsck _is_ recommended

> EXT3-fs warning: mounting fs with errors, running e2fsck is recommended

same

> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.


