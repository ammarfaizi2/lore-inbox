Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316584AbSE0MTL>; Mon, 27 May 2002 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSE0MTK>; Mon, 27 May 2002 08:19:10 -0400
Received: from ftp.nfas.org.sz ([196.28.7.66]:31406 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316584AbSE0MTJ>; Mon, 27 May 2002 08:19:09 -0400
Date: Mon, 27 May 2002 13:52:16 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <act7oa$5cl$1@ID-44327.news.dfncis.de>
Message-ID: <Pine.LNX.4.44.0205271351130.28930-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Andreas Hartmann wrote:

> rsync allocates all of the memory the machine has (256 MB RAM, 128 MB swap). 
> When this occures, processes get killed like described in the posting 
> before. The machine doesn't respond as long as the rsync - process isn't 
> killed, because it fetches all the memory which gets free after a process 
> has been killed.

And the rsync process never gets singled out? nice!

	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

