Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWGGW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGGW1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGGW1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:27:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:44596 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932357AbWGGW1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:27:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R0mQ8pyQ0qpmGFBCwqw/7aTBqCgLKyCZfpv+LC4E5YrufsFclNQf4vUXDTOAf5eG8R7ocgQ6IbJ9USBXlf7ETWP1bQI4/k6GqmTG/3FDHs7eJrJa91fik0DcO3bEH5c6bExaLw1rKKNe79FzLB8j+YCXfCBUDDxyE7RaA63OT9Y=
Message-ID: <dda83e780607071527m346a2f90mdb0c7d9145208533@mail.gmail.com>
Date: Fri, 7 Jul 2006 15:27:46 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Bret Towe" <magnade@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 bttv modprobe null pointer dereference
In-Reply-To: <dda83e780607071004o75a9c764yd0e42802477e1b91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com>
	 <20060706215225.290360bf.akpm@osdl.org>
	 <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
	 <20060707064610.GA27347@redhat.com>
	 <dda83e780607071004o75a9c764yd0e42802477e1b91@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/06, Bret Towe <magnade@gmail.com> wrote:
> On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> > On Thu, Jul 06, 2006 at 10:19:09PM -0700, Bret Towe wrote:
> >  > ill be recompiling without it and seeing if anything looks odd
> >  > and the mce i think has always been there as i recall seeing it
> >  > when i did previous bug reports
> >
> > If you're getting recurring machine checks, that smells strongly
> > like a hardware problem.  Have you tried running memtest on
> > this box ?
>
> not for some time if the memory is bad its must not be very much
> cause im not seeing any random effects id expect of memory failure
> i will however run a test tho and see what turns up

i had only time for 1 pass but it didnt turn up any errors at all

> >
> >                 Dave
> >
> > --
> > http://www.codemonkey.org.uk
> >
>
