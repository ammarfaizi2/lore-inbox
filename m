Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHQCP3>; Thu, 16 Aug 2001 22:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRHQCPT>; Thu, 16 Aug 2001 22:15:19 -0400
Received: from cs.utexas.edu ([128.83.139.9]:31893 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S269454AbRHQCPA>;
	Thu, 16 Aug 2001 22:15:00 -0400
Date: Thu, 16 Aug 2001 21:15:13 -0500 (CDT)
From: Kalpesh Shah <kalpesh@cs.utexas.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Socket options
In-Reply-To: <874rr7zb9a.fsf@ceramic.fifi.org>
Message-ID: <Pine.GSO.4.33.0108162114440.24575-100000@cabaco.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a linux 2.4.6 kernel...any suggestions for that??

kalpesh


On 16 Aug 2001, Philippe Troin wrote:

> Kalpesh Shah <kalpesh@cs.utexas.edu> writes:
>
> > I would like to be CC'ed any answers/comments to my question.
> >
> > are /proc/sys/net/ipv4/tcp_rmem and /proc/sys/net/ipv4/tcp_wmem the socket
> > Buffer (receive and send respectively) Sizes in the linux kernel.
> >
> > If yes then how come when I try to set these buffer sizes by using the
> > SO_RCVBUFF and SO_SNDBUFF variables it automatically multiplies the values
> > by 2 ????
>
> To remain BSD-compatible.
>
> There was a thread about this on lkml one week ago. Check the
> archives.
>


