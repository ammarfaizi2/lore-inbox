Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275294AbRJUMx2>; Sun, 21 Oct 2001 08:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRJUMxS>; Sun, 21 Oct 2001 08:53:18 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:26885 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275294AbRJUMxF>; Sun, 21 Oct 2001 08:53:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Sun, 21 Oct 2001 08:53:38 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Rohland <cr@sap.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <E15vHVx-0001Nc-00@ii.uib.no> <20011021143409.A4900@ii.uib.no>
In-Reply-To: <20011021143409.A4900@ii.uib.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011021125313Z275294-17409+2195@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 08:34, Jan-Frode Myklebust wrote:
> > Like someone said before a while ago.  This is a binutils problem. 
> > Update to a newer version.
>
> Upgraded to binutils 2.11.92.0.7, but it didn't help.
>
>
>   -jf
2.11.92.0.7-2 works fine 
and just to let you know,  You wont see any gain in compile time unless your 
drive is running on Pio Mode. In which case I think compile time for the 
kernel is the least bit of your hdd load time worries. 
