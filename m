Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRCAQg6>; Thu, 1 Mar 2001 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCAQgi>; Thu, 1 Mar 2001 11:36:38 -0500
Received: from idiom.com ([216.240.32.1]:11013 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S129706AbRCAQgg>;
	Thu, 1 Mar 2001 11:36:36 -0500
Message-ID: <3A9E72D3.36B28B8F@namesys.com>
Date: Thu, 01 Mar 2001 19:03:31 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Todd <todd@unm.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        brian jenkins <bjenkins@thresholdnetworks.com>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <Pine.A41.4.33.0102282123180.68876-100000@aix09.unm.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd wrote:
> 
> hans,
> 
> we've found that the TCP and UDP performance on 2.4 is *dramatically*
> better than 2.2.  with the acenic gig-e driver on PIII-933 UP (66MHz x
> 64bits PCI) we are getting 993 Mb/s with 2.4.0 with jumbo frames (about
> 850 Mb/s with standard ethernet frames).  the best number we got with 2.2
> was about 650 with jumbos and 550 with standard.
> 
> i'd recommend it's networking performance to anyone.
> 
> todd underwood
> todd@unm.edu
> 
> On Thu, 1 Mar 2001, Hans Reiser wrote:
> 
> > Date: Thu, 01 Mar 2001 02:26:20 +0300
> > From: Hans Reiser <reiser@namesys.com>
> > To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> > Subject: What is 2.4 Linux networking performance like compared to BSD?
> >
> > I have a client that wants to implement a webcache, but is very leery of
> > implementing it on Linux rather than BSD.
> >
> > They know that iMimic's polymix performance on Linux 2.2.* is half what it is on
> > BSD.  Has the Linux 2.4 networking code caught up to BSD?
> >
> > Can I tell them not to worry about the Linux networking code strangling their
> > webcache product's performance, or not?
> >
> > Hans
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

The problem is that I really need BSD vs. Linux experiences, not Linux 2.4 vs.
2.2 experiences, because the webcache industry tends to strongly disparage Linux
networking code, so much better isn't necessarily good enough.

Hans
