Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbVKRUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbVKRUGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbVKRUGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:06:24 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:16119 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161164AbVKRUGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:06:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DU+c2M3LFOsW0CCdqz8G14FHc9m5Zv5CxO+d1mVdWclV6Wzl3tWVsWgCQdaVZ0+PV8Aaos8ZvxWKF0yKXxa7fahYxPG4/n5lvy+2xhFXOnqPRrw9GQRx+iWVXPQltECJ8HyMGx5drBfEpLeBVLi7xzqTpy0DroapqtP+Tdo5R4I=
Message-ID: <625fc13d0511181206r6a0509c0o5b11e0afea8857b7@mail.gmail.com>
Date: Fri, 18 Nov 2005 14:06:23 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, scjody@steamballoon.com
In-Reply-To: <Pine.LNX.4.64.0511181142140.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051118173930.270902000@press.kroah.org>
	 <20051118173054.GA20860@kroah.com> <20051118173106.GB20860@kroah.com>
	 <625fc13d0511181134lc074b8avcc8db47b8723583@mail.gmail.com>
	 <Pine.LNX.4.64.0511181142140.13959@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 18 Nov 2005, Josh Boyer wrote:
> >
> > MTD also has a CVS tree... which begs the question as to whether or
> > not CVS trees can be added to the SCM type?
>
> I'd argue against it.
>
> CVS is a piece of crap, and anyody who maintaines stuff in CVS just makes
> it harder to ever merge back. That's not just a theory - we've had that
> situation happen in real life over the years, which is why I definitely
> don't want to see any external CVS trees given any kind of recognition at
> all.

You'll get no argument from me.  I've been meaning to bug the MTD
maintainers about switching altogether anyway.

Someone was going to ask about it though, so I thought I'd get "first post" ;).

josh
