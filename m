Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSE1K4i>; Tue, 28 May 2002 06:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSE1K4h>; Tue, 28 May 2002 06:56:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59128 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313638AbSE1K4g>; Tue, 28 May 2002 06:56:36 -0400
Subject: Re: 2.4 SRMMU bug revisited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: szepe@pinerecords.com, colin@gibbs.dhs.org, linux-kernel@vger.kernel.org,
        tcallawa@redhat.com, sparclinux@vger.kernel.org,
        aurora-sparc-devel@linuxpower.org
In-Reply-To: <20020527.204114.126236775.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 12:58:38 +0100
Message-Id: <1022587118.4124.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 04:41, David S. Miller wrote:
>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Mon, 27 May 2002 23:30:16 +0200
> 
>    http://linux.bkbits.net:8080/linux-2.4/
>    
> The BK repository to use has the URL:
> 
> 	bk://linux.bkbits.net/linux-2.4
> 
> The web stuff is updated still by hand and is as a result chronically
> out of date.

Which is a concern since both Linus and Larry made it clear bitkeeper
would *NEVER* be required of contributors. Is there nothing generating
nightly tarballs off cron right now ?

