Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWBMPsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWBMPsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWBMPsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:48:00 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:4563 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbWBMPr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:47:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IzOtw++s6Hw7qyxFjAv15NH//4qrreRw/xbHt7HVjIh1bHWoRYOBUuZNuNW5KaiYTor3b3RIqaYvmf3H5aNn7n3bhhLNzbfsitSuEdHqr4yiXh7Cdz1ozBvqUzRLqKHPoEfVK66iItLxN9JoFhbVYdkr5XbOz54SCIGWrKwjZl4=
Message-ID: <5a2cf1f60602130747y5de6a8s1038eaed9fd223c0@mail.gmail.com>
Date: Mon, 13 Feb 2006 16:47:58 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
In-Reply-To: <43F0A53D.nailKUSZ1BXK2@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo> <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <200602092241.29294.dhazelton@enter.net>
	 <43F08D45.nailKUSE1SA4H@burner>
	 <5a2cf1f60602130608qf6a2575ucbd57615eb32cc67@mail.gmail.com>
	 <43F0A53D.nailKUSZ1BXK2@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> > On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > "D. Hazelton" <dhazelton@enter.net> wrote:
> > >
> > > > > Are you accepting such a patch?
> > > >
> > > > If his response to the last patch someone provided is any example the answer
> > > > is going to be no. And I firmly believe the old adage that a leopard can't
> > > > change it's spots.
> > >
> > > Any patch that
> > >
> > > -       does not break things
> > >
> > > -       fits into the spirit of the currnt implementation
> > >
> > > -       offers useful new features
> > >
> > > -       conforms to coding style standards
> > >
> > > -       does not need more time to integrate than I would need to
> > >         write this from scratch
> > >
> > > Unfortunately, many people who send patches to me do not follow
> > > these simple rules.
> >
> > I am still waiting for an answer as to whether such a patch would be
> > accepted. We will take on the practical details later on.
>
> If this answer is not sufficient to you, you seem to be wrong here.

We probably misunderstood each other here. I want a technical approval
regarding the proposal I made (which is "publicise the os specific to
b,t,l mapping found by cdrecord").

Then I write the patch and I will make sure it will pass all your
defined criteria.

Jerome
