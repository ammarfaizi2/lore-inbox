Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUJ0VWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUJ0VWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUJ0VTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:19:16 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:34034 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262755AbUJ0VNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:13:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TDdTdOhipccVFDTVZX30jxSf1Hm5GtUFA5fHUt1QMW91QEKeR0U7vf7Q+AWkOksJOy59mxzdSDLcAra2hbGDMRCjo+Ns4jx9He6tVXsMt9Prhoaxt6egufE6GWI16UYgl/pqeLmyVX3xv5PEP8lXmuUFoAeN3NMNoejzR4F3PI4=
Message-ID: <21d7e997041027141358b05c41@mail.gmail.com>
Date: Thu, 28 Oct 2004 07:13:06 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The naming wars continue...
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410271323040.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com>
	 <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
	 <20041027200805.GA17759@4t2.com>
	 <Pine.LNX.4.58.0410271323040.28839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The subject line of my announcement was
> 
>         Subject: Linux 2.6.9-rc4 - pls test (and no more patches)
> 
> and the body was
> 
>         Ok,
>          trying to make ready for the real 2.6.9 in a week or so, so please give
>         this a beating, and if you have pending patches, please hold on to them
>         for a bit longer, until after the 2.6.9 release. It would be good to have
>         a 2.6.9 that doesn't need a dot-release immediately ;)
> 
>         The appended shortlog gives a pretty good idea of what has been going on.
>         Mostly small stuff, with some architecture updates and an ACPI update
>         thrown in for good measure.
> 
> (plus the shortlog).
> 
> Not exactly "hidden", was it?

To sum up, why don't you call everything before you reach this point
-pre and then when you decide to write the mail and realise you want
to say no more patches just check in  patch calling it -rc ? you claim
you don't know when to diffrentiate between -pre and -rc, (or maybe
you don't care) well how do you decide to write the above e-mail? I
think that would satisfy nearly everyone and I don't see what would be
so different from your POV, but it is in the end up to you...

> So far, nobody has had a good reason. People are just complaining, because
> this is an area where you can complain without actually having any real
> hard technical input. It's "easy" to have an opinion.
> So guys, look at the big picture. Is this really worth worrying over?

There has been a fair bit of bike shedding going on... so I think we
should use some sort of timber and paint it red...

Dave.
