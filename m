Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSFEVNf>; Wed, 5 Jun 2002 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSFEVNe>; Wed, 5 Jun 2002 17:13:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41201 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316422AbSFEVNd>; Wed, 5 Jun 2002 17:13:33 -0400
Subject: Re: pctel modem bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Boris Kimelman <erwin138@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CFE6AE0.2000600@netvision.net.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 23:06:35 +0100
Message-Id: <1023314795.2443.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 20:47, Boris Kimelman wrote:
> Hello,
> you probably know about this but i'll tell you anyway. there is a bug 
> related to pctel modems. a very nice person made drivers for linux of 
> this modems and they can work on linux. the problem is that when the 
> modem finally dials after all the configuration, it puts out a "no 
> carrier" message and disconnects. please handle the problem and if it 
> was already fixed please reply to me and say which kernel i should download.

PCtel modem drivers are not last time I checked open source. They are
also not part of the base kernel. You need to ask whoever made the
packages

