Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318404AbSHERn6>; Mon, 5 Aug 2002 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHERn6>; Mon, 5 Aug 2002 13:43:58 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:11688 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S318404AbSHERnz>;
	Mon, 5 Aug 2002 13:43:55 -0400
Subject: Re: [PATCH] write_super is not for syncing (take 3)
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, alan@redhat.com
In-Reply-To: <20020805183704.A18612@infradead.org>
References: <1028568893.1805.270.camel@tiny> 
	<20020805183704.A18612@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 13:48:43 -0400
Message-Id: <1028569723.1759.275.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 13:37, Christoph Hellwig wrote:
> On Mon, Aug 05, 2002 at 01:34:53PM -0400, Chris Mason wrote:
> > Below are just the hunks that change VFS code, against 2.4.19-final. 
> > The reiserfs bits will come once this gets accepted.  Please review and
> > throw something blunt at me if you don't want this in the kernel.
> 
> Could you please get that tested in 2.5 or -ac first?

It is being tested in the suse kernel now.  Alan, if you want it, I'll
rediff against 2.4.19-ac.

-chris


