Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUFRCRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUFRCRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbUFRCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:17:12 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:20501 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264949AbUFRCRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:17:06 -0400
Message-ID: <5b18a542040617191740fa8e61@mail.gmail.com>
Date: Thu, 17 Jun 2004 22:17:04 -0400
From: Erik Harrison <erikharrison@gmail.com>
To: 4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D2474D.8030303@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <40D24606.6040009@yahoo.com.au> <40D2474D.8030303@opensound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 18:37:17 -0700, 4Front Technologies
<dev@opensound.com> wrote:
> 
> Nick Piggin wrote:
> > 4Front Technologies wrote:
> >
> >>
> >> It's time everybody started to pay some attention to in-kernel
> >> interfaces because
> >> Linux has graduated out of your personal sandbox to where other people
> >> want to use
> >> Linux and they aren't kernel developers.
> >>
> >
> > No, it is still our personal sandbox actually, and it is you
> > who must pay attention to in-kernel interfaces.
> > 
> The problem is that we ARE paying attention to in-kernel interfaces or else
> why would our software work on Linux 2.6.7 or Fedora or Mandrake?
> 

Because the patched kernels shipped by Redhat and Mandrake didn't
introduce this particular bug?

Look, I sympathize a bit. I am Joe User, and I have run a hand
configured stock kernel for about as long as I've known how, for much
the reasons you describe. I am in the happy position of not having any
users other than myself.

Novell/SuSE don't have that luxury, and for various reasons run
patched kernels. If this weren't common knowledge, there might be some
legitimate complaint that a bug in SuSE is improperly seen as a bug in
Linux proper. But it's not like SuSE (or Redhat, or Debian) has some
man behind a curtain pulling strings and patching kernels while
Dorothy watches on oblivious. No one was lied to. It's just a bug,
file it with the maintainer (SuSE), and get on with your life.

However I for one, would like to see more of these vendor patches in
the mainline. I think it's the wrong place for the vendor to add
value, most of the time. The peer review of getting into Linus's tree
would make me sleep better at night if I depended on features provided
by vendor patches. Hopefully, there will be a day when the idea of
shipping a patched kernel is ridiculous for 99% of vendor needs.

-Erik

> > Or were you hoping that we're all here just to make your life
> > easier?
> > 
> I don't expect you to make my life easier. Why don't we all take
> a huge plunge backwards to circa 1958 and start programming by throwing
> switches?. Are you against making linux better or what?
> 
> 
> 
> 
> best regards
> 
> Dev Mazumdar
> ---------------------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
> Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
> ---------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
