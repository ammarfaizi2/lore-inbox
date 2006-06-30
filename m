Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWF3Nlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWF3Nlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWF3Nlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:41:51 -0400
Received: from web33302.mail.mud.yahoo.com ([68.142.206.117]:12710 "HELO
	web33302.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932619AbWF3Nlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:41:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TNnI9oRo9994SqnKr6S9X7vn/rS9QyOLYKoQ8OGtCoxPt2i1I302MEGs2cKMPuFPhaG6UJ/rDtWuQWeZehjADJBAsA9r7qy5lW5Twmlqk4vGCyKmCxJ9zYVVvxpb84PQ6Pm4+JB/lnOLhMpfxt8isSO/0dJSV2Nph1fbPv6ptfk=  ;
Message-ID: <20060630134149.11464.qmail@web33302.mail.mud.yahoo.com>
Date: Fri, 30 Jun 2006 06:41:49 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Mike Galbraith <efault@gmx.de>
Cc: =?ISO-8859-1?Q?=20=22Bj=F6rn=22?= Steinbrink 
	 <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151289182.7470.31.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Mike Galbraith <efault@gmx.de> wrote:

> On Sun, 2006-06-25 at 13:45 -0700, Danial Thom
> wrote:
> 
> > I think the one thing we can surmise from
> this
> > thread is that you can't rely on kernel usage
> > statistics to be accurate, as its likely that
> > there are many, many cases that don't work
> > properly. It was always wrong in 2.4 as well.
> 
> Once identified, problems tend to get fixed. 
> This one will probably be
> history soon.  You know the old saying
> though... "There are lies, there
> are _damn_ lies, and then there are
> _statistics_".

The usefulness of statistics is a function of the
breadth of understand of the person interpreting
them. 

But I don't think that applies here, because we
are not questioning the conclusions from the
statistics, only the accuracy of the gathering.
Its a completely different thing to say, for
example, that population growth is due to too
many babies when it might be immigration or a
reduction in the death rate, than it is to say
that the numbers gathered are simply wrong.

The truth is that you guys can't be bothered
unless the numbers are so far off that its an
embarrasment. Until someone who cares about it
(and knows  how to do it) puts their nose to the
grindstone and makes sure that everything is
being done correctly, they'll be largely useless.


DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
