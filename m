Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSJVTyS>; Tue, 22 Oct 2002 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264824AbSJVTyR>; Tue, 22 Oct 2002 15:54:17 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:30967 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264822AbSJVTyO>; Tue, 22 Oct 2002 15:54:14 -0400
Date: Tue, 22 Oct 2002 16:00:22 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021022160022.B24843@redhat.com>
References: <1035310415.31873.120.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0210221113390.1563-100000@blue1.dev.mcafeelabs.com> <20021022143708.F20957@redhat.com> <1035310415.31873.120.camel@irongate.swansea.linux.org.uk> <3DB5A593.9090506@netscape.com> <20021022152843.I20957@redhat.com> <1035310415.31873.120.camel@irongate.swansea.linux.org.uk> <3DB5AC14.7000600@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB5AC14.7000600@netscape.com>; from jgmyers@netscape.com on Tue, Oct 22, 2002 at 12:50:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 12:50:44PM -0700, John Gardiner Myers wrote:
> 
> 
> Benjamin LaHaise wrote:
> 
> >*Which* proposals?  There was enough of a discussion that I don't know 
> >what people had decided on.
> >
> Primarily the ones in my message of Tue, 15 Oct 2002 16:26:59 -0700. In 
> that I repeat a question I posed in my message of Tue, 01 Oct 2002 
> 14:16:23 -0700.

How does it perform?

> There's also the IOCB_CMD_NOOP strawman of Fri, 18 Oct 2002 17:16:41 -0700.

That's going in unless there are any other objections to it from folks.  
Part of it was that I had problems with 2.4.43-bk not working on my 
test machines last week that delayed a few things.

		-ben
-- 
"Do you seek knowledge in time travel?"
