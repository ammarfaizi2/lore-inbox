Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSJYIhN>; Fri, 25 Oct 2002 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJYIhN>; Fri, 25 Oct 2002 04:37:13 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:5849 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261311AbSJYIhM>; Fri, 25 Oct 2002 04:37:12 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Duncan Sands <baldrick@wanadoo.fr>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of yield() in the kernel
Date: Fri, 25 Oct 2002 10:43:07 +0200
User-Agent: KMail/1.4.7
References: <200210151820.24429.m.c.p@wolk-project.de> <200210151827.45149.baldrick@wanadoo.fr>
In-Reply-To: <200210151827.45149.baldrick@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210251043.07960.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 18:27, Duncan Sands wrote:
> > > This already bit ext3 transaction batching, c.f. Andrew Morton's
> > >
> > >> [PATCH] remove the sched_yield from the ext3 fsync path
> >
> > where did you read this ^^? :)
> >
> > ciao, Marc
>
> http://linux.bkbits.net:8080/linux-2.5/cset@1.733.7.6?nav=index.html|Change
>Set@-7d

Actually its

http://linux.bkbits.net:8080/linux-2.5/cset@1.781.32.3?nav=index.html|ChangeSet@-3w

Sorry about that.

Duncan.
