Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVKOFvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVKOFvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVKOFvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:51:46 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:6760 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751342AbVKOFvp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:51:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JOvAaZt6Edrc1OBfDbkpbcSYch5SZ6YDsgJ+YGQziHUBZNhzqOKu0mM4tBCAyI6+i5vTk9+VRDdfKziJVVeYBpOT/YWhM41fTNm+IUEgyN7P+6jWrub0dDqaVaT6YtvhgQKsUL6QT28dGX8FLMVFp5vS5fjjxQHf5xmfd9j4bRA=
Message-ID: <2cd57c900511142151h7d8f97b3p@mail.gmail.com>
Date: Tue, 15 Nov 2005 13:51:44 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051115043846.GA28005@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com>
	 <2cd57c900511141708y5d11fd34n@mail.gmail.com>
	 <20051115043846.GA28005@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/15, Greg KH <greg@kroah.com>:
> On Tue, Nov 15, 2005 at 09:08:30AM +0800, Coywolf Qi Hunt wrote:
> > 2005/11/15, Greg KH <gregkh@suse.de>:
> > > So, I've been working on a document for the past week or so to help
> > > alleviate a lot of these problems.  If nothing else, it should be a place
> > > where anyone can point someone to when they ask the common questions, or
> > > do something in the not-correct way.  I'd like to add this to the Linux
> > > kernel source tree, so it will be kept up to date over time, as things
> > > change (like the development process.)  Ideally I'd like to put it in
> > > the main directory as HOWTO, but I don't know how others feel about
> >
> > You put it in the top directory to draw the most attention? Compare to
> > source trees of other kernel projects, Linux source tree looks clean.
> > Please don't spoil that. What's wrong with Documentation/ ?
>
> People do not seem to even realize Documentation/ is there :(

Those who don't notice Documentation, don't deserve it, and are not
likely/willingly to be the audience,

>
> Now if those same people would notice anything in the root directory
> either, is another story...

That is rather like top-posting or CAPITALIZATION, or spamming.

>
> It's just a suggestion.
>

We are unlikely to relocate files. So if it gets there, it'll stay
there all along.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
