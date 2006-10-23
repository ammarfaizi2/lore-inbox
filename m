Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWJWS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWJWS3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWJWS3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:29:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:370 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964992AbWJWS3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:29:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UCNTA/nbu71AJmro+G3qmQKjKJaXb5/cI1rZgpPAgwkuQ5+0hfhT5sxDHdF+fxUx9zCvAzbJnTwpvJcEcc2gJIqc7Dg5StOktZG4pv1hvpNf3VuYk8fdiRYq9hUwnd8m38BPOCfkeTsoBXRgGHJ/5XvSjh3VlqSeZxZy6nBIEag=
Message-ID: <5bdc1c8b0610231129i6f769187l97a80c649e1a4d09@mail.gmail.com>
Date: Mon, 23 Oct 2006 11:29:11 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mike Galbraith" <efault@gmx.de>, "Daniel Walker" <dwalker@mvista.com>,
       "Manish Lachwani" <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161621286.2835.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>
	 <1161621286.2835.3.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2006-10-20 at 11:00 -0400, Lee Revell wrote:
> > On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > > i've released the 2.6.18-rt6 tree, which can be downloaded from the
> > > usual place:
> > >
> > >   http://redhat.com/~mingo/realtime-preempt/
> >
> > This does not work here.  It boots but then wants to fsck my disks, and
> > dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
> > 2.6.18-rt5 works and does not want to fsck the disks.
>
> I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
> are the release notes?
>
> Lee

I've been running it for a few hours on my AMD64. No problems so far.

- Mark

lightning ~ # uname -a
Linux lightning 2.6.18-rt7 #1 PREEMPT Mon Oct 23 07:28:51 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
lightning ~ # uptime
 11:28:25 up  3:53,  2 users,  load average: 0.20, 0.10, 0.28
lightning ~ #
