Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUCFEd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 23:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUCFEd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 23:33:29 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:20670 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261586AbUCFEd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 23:33:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [PATCH 1/2] NET: fix class reporting in TBF qdisc
Date: Fri, 5 Mar 2004 23:33:21 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@diku.dk>,
       marek cervenka <cer20um@axpsu.fpf.slu.cz>, linux-net@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk> <200403050148.22964.dtor_core@ameritech.net> <4048E9C0.6010707@matchmail.com>
In-Reply-To: <4048E9C0.6010707@matchmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403052333.21567.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 03:57 pm, Mike Fedyk wrote:
> Dmitry Torokhov wrote:
> > ===================================================================
> > 
> > 
> > ChangeSet@1.1649, 2004-03-05 01:18:18-05:00, dtor_core@ameritech.net
> >   NET: TBF trailing whitespace cleanup
> > 
> > 
> >  sch_tbf.c |   68 +++++++++++++++++++++++++++++++-------------------------------
> >  1 files changed, 34 insertions(+), 34 deletions(-)
> > 
> > 
> > ===================================================================
> > 
> > 
> > 
> > diff -Nru a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
> > --- a/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
> > +++ b/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
> > @@ -62,7 +62,7 @@
> >  
> >  	Algorithm.
> >  	----------
> > -	
> > +
> 
> That's a lot of whitespace cleanup in there too.
> 

It's only whitespace cleanup... See the changeset comment. Ahh, I see...
I have the same subject on both emails. Doh! Well, it was almost 2AM...

-- 
Dmitry
