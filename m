Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVL2Jtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVL2Jtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVL2Jtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:49:51 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:10488 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965134AbVL2Jtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:49:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bC+7yXGa/UekDW7F5ItfODXxEIPlLVYTv3k9+uH9cHRj266gAO2gTJ0Vb+Dk1Ki8VT5bFqvvaf7AiMmzdhUyMNqZjAhbRnfAaleTDtAetIk8R1u9KxcOqjP8L9JTHloBAAxj/AjaeKLmkvSyAKAxTVIIQk6Q2PD59yyfFnuxrWo=
Message-ID: <2cd57c900512290149t545dc981h@mail.gmail.com>
Date: Thu, 29 Dec 2005 17:49:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: recommended mail clients
Cc: Jaco Kroon <jaco@kroon.co.za>, jason@stdbev.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
In-Reply-To: <1135622935.8293.76.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>
	 <1135607906.5774.23.camel@localhost.localdomain>
	 <200512261535.09307.s0348365@sms.ed.ac.uk>
	 <1135619641.8293.50.camel@mindpipe>
	 <0f197de4ee389204cc946086d1a04b54@stdbev.com>
	 <1135621183.8293.64.camel@mindpipe> <43B03658.9040108@kroon.co.za>
	 <1135622935.8293.76.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/27, Lee Revell <rlrevell@joe-job.com>:
> On Mon, 2005-12-26 at 20:28 +0200, Jaco Kroon wrote:
> > I've looked at a few clients and it seems I'm stuck with mozilla for
> > at least a while.  Whilst probably the buggiest client there is it
> > does look like it's the best suited for what I want.  I might switch
> > to FireFox (which iirc does have an "insert file" feature - which
> > might also solve this problem).
> >
> > For the moment though I'm quickly hacking together a bash script that
> > wraps the sendmail binary that can be used specifically for submitting
> > patches
>
> I am amused at how many people are not scared of kernel hacking but will
> go to great lengths to avoid looking at the Mozilla code :-)


To me, looking at Mozilla code means a lot. I'm too lazy to dig into
gtk and glib. But kernel code is quite straightforward.

-- Coywolf


>
> IMHO "Insert File" is suboptimal, it's better to make C&P work right.
>
> Lee
>

--
Coywolf Qi Hunt
