Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313005AbSC0NAe>; Wed, 27 Mar 2002 08:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313004AbSC0NAZ>; Wed, 27 Mar 2002 08:00:25 -0500
Received: from isengard.sl.pt ([212.55.140.11]:39941 "EHLO angelina.sl.pt")
	by vger.kernel.org with ESMTP id <S313005AbSC0NAT>;
	Wed, 27 Mar 2002 08:00:19 -0500
Date: Wed, 27 Mar 2002 13:06:01 +0000 (WET)
From: Nuno Miguel Rodrigues <nmr@co.sapo.pt>
X-X-Sender: <nmr@angelina.sl.pt>
To: Frank Schaefer <frank.schafer@setuza.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler priorities
In-Reply-To: <1017222101.1123.12.camel@ADMIN>
Message-ID: <20020327125828.U2343-100000@angelina.sl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002, Frank Schaefer wrote:

> On Tue, 2002-03-26 at 18:55, Mike Fedyk wrote:
> > On Tue, Mar 26, 2002 at 11:41:39AM +0000, Nuno Miguel Rodrigues wrote:
> > >
> > > Hi,
> > >
> > > Does Linux support a fixed process scheduling priority, in the 2.4.x
> > > releases?
> > > If not, are there any plans to support it?
> >
> > Can you elaborate?  What do you mean by "fixed process"?  Minimum percentage
> > of CPU?
> Hi,
>
> I'd read this ...
> a fixed prority of some process ...

Indeed.  In other words a priority that is not dynamically adjusted over
time.  Like a real-time scheduling priority.

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

