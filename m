Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWBIUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWBIUKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWBIUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:10:10 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:9303 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750753AbWBIUKI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:10:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fj75mXIO7AjlflfWhMIcodW6zMQttFiRcyHi0es4AdDPPp/X5uU+5lXSF/6GtDHoLlGuxEi5dxNGsD6IDv0gS6PELqhFUF0FDMPnKS39sx6F9b1bf3AMUlW0BZD0K1kqQXRvxaJPQ1780dsAw0Bf3V9mh4t0pBJdXMy0GfMCeSg=
Message-ID: <5a2cf1f60602091210o2014410ax31eae84e887956b3@mail.gmail.com>
Date: Thu, 9 Feb 2006 21:10:07 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       linux-kernel@vger.kernel.org, cdwrite@other.debian.org,
       acahalan@gmail.com
In-Reply-To: <20060208221305.GF2353@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	 <43E27792.nail54V1B1B3Z@burner>
	 <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
	 <43E374CF.nail5CAMKAKEV@burner>
	 <20060203182049.GB11083@merlin.emma.line.org>
	 <43E3A19E.nail6A511N92B@burner> <20060203184240.GC11241@voodoo>
	 <43E3AA95.nail6AV21A253@burner>
	 <20060203192827.GC18533@merlin.emma.line.org>
	 <20060208221305.GF2353@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/06, Pavel Machek <pavel@ucw.cz> wrote:
[...]
> > I just don't want my name tainted with accidents that happen during
> > integration because you don't have a recent Linux installation. The
> > RLIMIT_MEMLOCK was enough of an effort, my first patch would've worked,
> > too, hence the GPL.
>
> Well, mailing patch with notice that it is not okay to modify it is
> strange behaviour, and if I was Joerg, I'd just drop that patch, too.

That would be true except if Joerg hadn't started with the exact same
behavior. It would seem that Joerg would be capable of understanding
the irony there.

But maybe if Joerg would move his pride out of the way for 30 seconds,
have a decent look at the patch, return a technical commentary (or
point to an existing one), we could move on. I am sure that Matthias
would be pretty happy to return a better patch. That would make
everybody happy.

Matthias, can you resend the patch, without your notice? Let's see if
Joerg look at it this time.

> If you really want the patch applied, submit it anonymously or
> something like that.

Anonymous submission is not good for tracability reasons...

Jerome
