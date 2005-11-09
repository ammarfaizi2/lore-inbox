Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVKIDT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVKIDT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVKIDT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:19:58 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:15812 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030270AbVKIDT5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:19:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JVeKj+Hchj9b3gTUL0EkzBFh7hb1LTyi7ntGOq4JT1/Y/y9/LaTOw9T//F2HsgezzdfnPpKu6j6JzD9OK7SyWQSqhDWk4NBJzuZflzfrEih2tkttL0S1N3acTSlkAFi6DB2WUcONODRKzFa7rOsjGVinkJ7OqORKYJjLONSfcoo=
Message-ID: <2cd57c900511081919m2e704741j@mail.gmail.com>
Date: Wed, 9 Nov 2005 11:19:56 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] Re: Linux 2.6.14.1
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
In-Reply-To: <20051109021840.GB23537@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051109010729.GA22439@kroah.com>
	 <2cd57c900511081805s3d385110r@mail.gmail.com>
	 <20051109021840.GB23537@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/9, Greg KH <greg@kroah.com>:
> On Wed, Nov 09, 2005 at 10:05:43AM +0800, Coywolf Qi Hunt wrote:
> > 2005/11/9, Greg KH <gregkh@suse.de>:
> > > We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
> > >
> > > The diffstat and short summary of the fixes are below.
> > >
> > > I'll also be replying to this message with a copy of the patch between
> > > 2.6.14 and 2.6.14.1, as it is small enough to do so.
> > >
> > > The updated 2.6.14.y git tree can be found at:
> > >         rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
> > > and can be browsed at the normal kernel.org git web browser:
> > >         www.kernel.org/git/
> >
> >
> > I'd appreciate it that if you would not overwrite the 2.6.14 record on
> > the kernel.org page, but add a new record for 2.6.14.y instead. It
> > would benefit others too. FYI: http://lkml.org/lkml/2005/10/9/18
>
> Sorry, but I am not in charge of that at all.  Please contact the
> kernel.org web masters if you want to discuss this.  And as 2.6.14 now
> has a documented security issue, I wouldn't recommend it being displayed
> on the kernel.org page anyway.
>
> Tools like ketchup can handle updating to the proper kernel version just
> fine if you want to use it, instead of having to rely on web pages :)

I tried a little. Nice tool! I have my own script with some of
ketchup's function partially for easy my lxr site maintaining. I'll
adapt my script to use it probably. Thanks.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
