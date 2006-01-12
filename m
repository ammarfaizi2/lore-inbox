Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWALKwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWALKwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWALKwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:52:23 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:43410 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030368AbWALKwV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:52:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WEIbMh1epyrjneMIv1IoOVwaHoYzK/3veyEhUB4cLvCPrOvipE3Gte11MMpPD5VeUzgSwaTAMNe+k3UBZblaPcKQxzj+zXaNrT5rdyxPhzaVoUAEI3j8ebBl518VIJBAptHgHggfo9VkqcsD733Y2APDVLdi/hBWEjts4BXufTI=
Message-ID: <5a4c581d0601120252g56c97df4y76b5fc5e1355508a@mail.gmail.com>
Date: Thu, 12 Jan 2006 11:52:20 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: [2.6.15-git6,-git7] hard lockup on FC4 exiting X (Intel I915)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970601112345p9306310ud935735f3b44e565@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0601111647i62f8c625q51a420ba9a9175e5@mail.gmail.com>
	 <21d7e9970601112345p9306310ud935735f3b44e565@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Dave Airlie <airlied@gmail.com> wrote:
> >  startx, fire up a gnome-terminal, exit it, Desktop->Logout...
> >  at this point the mouse arrow stills and the box locks up,
> >  keyboard dead, no response to pings.
> >
>
> Normally I'd accept blame for this, but I've not merged up yet, so at
> a guess the mutex patches probably did something... if not the some
> PCI ones perhaps..
>
> I don't suppose you can get a serial console hooked up (probably no
> real serial on that machine) or a netconsole..

Will plug both laptops in my router and try netconsole when I get
 back home later tonight, and report back...

Thanks,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
