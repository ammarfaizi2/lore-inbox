Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSDVSmW>; Mon, 22 Apr 2002 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSDVSmV>; Mon, 22 Apr 2002 14:42:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11407 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314420AbSDVSmR>; Mon, 22 Apr 2002 14:42:17 -0400
Date: Mon, 22 Apr 2002 14:42:15 -0400
From: Doug Ledford <dledford@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Abbey <linux@cabbey.net>,
        linux-kernel@vger.kernel.org
Subject: Re: possible GPL violation involving linux kernel code
Message-ID: <20020422144215.A877@redhat.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Abbey <linux@cabbey.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020421074858.A8318@infradead.org> <Pine.LNX.4.33.0204210147550.26531-100000@tweedle.cabbey.net> <20020421121732.A16765@infradead.org> <m11yd93zxg.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 08:10:35AM -0600, Eric W. Biederman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> > Where the heck did you get the impression from that this is required by
> > the GPL?
> > 
> > 	Christoph
> GPL section 3
> 
>   3. You may copy and distribute the Program (or a work based on it,
> under Section 2) in object code or executable form under the terms of
> Sections 1 and 2 above provided that you also do one of the following:
> 
>     a) Accompany it with the complete corresponding machine-readable
>     source code, which must be distributed under the terms of Sections
>     1 and 2 above on a medium customarily used for software interchange; or,

And Cristoph's point is that Promise has already complied with this exact
section.  The disk they distribute is a driver disk for Caldera Open
Linux.  That disk format happens to require that they put the regular
kernel drivers from the standard install disk into an image and then
simply add their new driver to that image as well.  That means you already
have all the GPL required source on the image you are installing because 
all those kernel modules are bit for bit duplicates of the ones that came 
with your open linux CD.  End of problem.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
