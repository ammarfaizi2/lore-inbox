Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWBWRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBWRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBWRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:47:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48088 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932101AbWBWRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:47:13 -0500
Subject: Re: Red Hat ES4 GPL Issues?
From: Arjan van de Ven <arjan@infradead.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Nick Warne <nick@linicks.net>, Chris Adams <cmadams@hiwaay.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43FDFBDE.2040304@wolfmountaingroup.com>
References: <43FCFDC6.9090109@soleranetworks.com>
	 <20060223145920.GA1311407@hiwaay.net>
	 <7c3341450602230831m1265e49g@mail.gmail.com>
	 <1140713030.4672.75.camel@laptopd505.fenrus.org>
	 <43FDFBDE.2040304@wolfmountaingroup.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 18:47:08 +0100
Message-Id: <1140716828.4672.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 11:15 -0700, Jeff V. Merkey wrote:
> Arjan van de Ven wrote:
> 
> >>But anyway, what has this thread to do with the kernel?
> >>    
> >>
> >
> >
> >since when does something need to be on-topic for Jeff Merkey to post to
> >lkml ? ;-)
> >
> >  
> >
> 
> I got the RPM's and located them from an earlier responder to the post.  
> It was just disturbing
> that RedHat does ont include the sources when you install from binary -- 
> which they always have
> before. 
> 

you forgot to download the cd images labeled "source".
What's the problem???

> I am glad Red Hat is still distributing the code, but I am disappointed 
> they are no longer
> including it in the base RPM install.

oh you don't mean the src.rpm but the full kernel source code installed?
That's explained in the release notes; it's 2 shell commands to create
it, and it's in a way silly to make an exception for the kernel here
compared to all other software. And CD real estate on the binary cd's is
scarse as well. 


