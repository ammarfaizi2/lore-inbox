Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314195AbSDQXVF>; Wed, 17 Apr 2002 19:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314194AbSDQXVE>; Wed, 17 Apr 2002 19:21:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15622 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314195AbSDQXVD>; Wed, 17 Apr 2002 19:21:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 1 Terabyte+ Disk Support?
Date: 17 Apr 2002 16:18:58 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9kvt2$2pq$1@cesium.transmeta.com>
In-Reply-To: <F50W2lSYgCSrlrCv3wB00016f23@hotmail.com>
stribution: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <F50W2lSYgCSrlrCv3wB00016f23@hotmail.com>
By author:    "bob dobalina" <mrdobalina@hotmail.com>
In newsgroup: linux.dev.kernel
> 
> The cut-off point for large disks in Redhat 6.2 and 7.2 appears to be around 
> 900 Gigabytes, I can get both Redhat 6.2 and 7.2 to see up to around 900 
> gigs as 1 disk. I've heard about a 64-bit IO patch for an older 2.x.x 'pre8' 
> release kernel but would like to know if theres a way to get this 
> accomplished with Redhat 6.2/Kernel 2.2.14-5. Any insight into this problem 
> would be greatly appreciated!
> 

Upgrade to 2.4.18.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
