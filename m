Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSHETKx>; Mon, 5 Aug 2002 15:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318847AbSHETKw>; Mon, 5 Aug 2002 15:10:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46575 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318845AbSHETKv>; Mon, 5 Aug 2002 15:10:51 -0400
Subject: Re: [PATCH] write_super is not for syncing (take 3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Mason <mason@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>, alan@redhat.com
In-Reply-To: <1028569723.1759.275.camel@tiny>
References: <1028568893.1805.270.camel@tiny> 
	<20020805183704.A18612@infradead.org>  <1028569723.1759.275.camel@tiny>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 21:32:32 +0100
Message-Id: <1028579552.18156.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 18:48, Chris Mason wrote:
> On Mon, 2002-08-05 at 13:37, Christoph Hellwig wrote:
> > On Mon, Aug 05, 2002 at 01:34:53PM -0400, Chris Mason wrote:
> > > Below are just the hunks that change VFS code, against 2.4.19-final. 
> > > The reiserfs bits will come once this gets accepted.  Please review and
> > > throw something blunt at me if you don't want this in the kernel.
> > 
> > Could you please get that tested in 2.5 or -ac first?
> 
> It is being tested in the suse kernel now.  Alan, if you want it, I'll
> rediff against 2.4.19-ac.

I'm chasing IDE stuff, now is the wrong moment for file system stuff

