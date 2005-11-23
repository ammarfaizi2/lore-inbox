Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVKWBJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVKWBJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVKWBJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:09:44 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:35784 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030295AbVKWBJn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:09:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lhrkOT/en+csYA6Nk+vqAmrykqVoJ6WN9xjlxpVq+Hf8m9DV7TZ2hi+d2Fqb+Ulu61iSIUgnz4nncnMDE3QVKXlb+GXngAvqKxyOIL1VUZ/W9stVBPGyMP8yqS9MzD59yha/MraxGmEOcWQizYbNjR5aUFElhC0/aj68mpJ+0y8=
Message-ID: <9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
Date: Tue, 22 Nov 2005 20:09:42 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Christmas list for the kernel
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20051122164353.4177c59a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <200511221839.24202.s0348365@sms.ed.ac.uk>
	 <9e4733910511221110j47e8ddcs1c9936db1eb5f0b4@mail.gmail.com>
	 <20051122164353.4177c59a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > On 11/22/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > On Tuesday 22 November 2005 18:31, Jon Smirl wrote:
> > > > There have been recent comments about the pace of kernel development
> > > > slowing.
> > >
> > > I doubt the diffstat from the last 6 kernel releases will tell this story.
> >
> > Andrew Morton said it: "He suggested this may indicate that the kernel
> > is nearing completion. "Famous last words, but the actual patch volume
> > _has_ to drop off one day," said Morton. "We have to finish this thing
> > one day."
> >
> > http://news.zdnet.co.uk/software/linuxunix/0,39020390,39221942,00.htm
> >
>
> I was wrong, as usual.  The trend at http://www.zip.com.au/~akpm/x.jpg is,
> I think, being maintained.

I wonder what that would look like if you pull Adrian Bunk's changes
out. He is generating thousands of lines of patches (they're good
patches but they don't add features).

--
Jon Smirl
jonsmirl@gmail.com
