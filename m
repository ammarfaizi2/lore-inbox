Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSEWHV2>; Thu, 23 May 2002 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSEWHV1>; Thu, 23 May 2002 03:21:27 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:35854 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313512AbSEWHV0>; Thu, 23 May 2002 03:21:26 -0400
Date: Thu, 23 May 2002 09:21:22 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020523072122.GB4370@louise.pinerecords.com>
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost> <20020523011144.GA4006@matchmail.com> <20020523070244.GA4370@louise.pinerecords.com> <20020523.000303.46488296.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 10:44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Thu, 23 May 2002 09:02:44 +0200
> 
>    > > 2. What is the "proper" fix for the patch collision between the raid
>    > > patch and the ext3 patch in /include/linux/fs.h? 
>    > 
>    > Use 2.4.
>    
>    Impossible on sparc32 on account of the lurking SRMMU bug.
>    (See yesterday's post by Joris Braakman <jorisb@nl.euro.net>.)
>    
> There have been several patches posted to deal with that
> problem

Splendid. Where have they been posted?


T.
