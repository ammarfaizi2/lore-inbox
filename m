Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933705AbWKSW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705AbWKSW7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933710AbWKSW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:59:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:62044 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933705AbWKSW7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:59:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=shCRBV/7oXG7SQbOfVWkbm9LEHbvGNiL9lRotuJ5JvG/tUXT5Q9/pfkcOARFNtNs8XbjY+4u+SQG6MlrLr/ftzCdJ0wqVMNzXR/OKdm/yEh2Tt9QKsl6Z09bU6R+vySenL5YTnTdcS3E6qGmBlvx/RTy/IkIu2/0YWe3HMO9bh4=
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
	SOFTWARE_SUSPEND
From: Romano Giannetti <romano.giannetti@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200611191955.23782.rjw@sisk.pl>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <200611191844.14354.rjw@sisk.pl>
	 <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
	 <200611191955.23782.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 23:59:39 +0100
Message-Id: <1163977180.13408.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 19:55 +0100, Rafael J. Wysocki wrote:
> On Sunday, 19 November 2006 19:21, Linus Torvalds wrote:
> > 
> > On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
> > >
> > > In fact that's up to 30 seconds on a modern box, usually less than that.
> > 
> > Right. If the machine boots quickly, it's fast. Of course, if the machine 
> > boots quickly, you might as well often just shut down and reboot.
> 
> Yes, if the only thing you want to run is the kernel.  The applications aren't
> going to start so quickly, you know. ;-)

Can I say a word in defence of STD? It's true that now that I have STR
working(*) for the first time on my old vaio I use it much less, but it
has been my salvation in the last four years, and for this I have to
thanks Nigel, Pavel, Rafael and all the people involved. And still now
it is very useful. I can STD a session with tens of application opened,
and come back after changing batteries  in less than a minute _doing
other things_, and not opening applications and files all over the
place. So yes, I think it's useful. 

And when suspend-to-both will work radiply and safely, that will be
great (and a point over The Other SO...) 

Romano 
 
(*) if only for this, all the troubles I had upgrading to Ubuntu Edgy
has been worthwhile. 


