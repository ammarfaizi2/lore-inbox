Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264141AbTCXKTs>; Mon, 24 Mar 2003 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264147AbTCXKTs>; Mon, 24 Mar 2003 05:19:48 -0500
Received: from mail.ithnet.com ([217.64.64.8]:43526 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264141AbTCXKTr>;
	Mon, 24 Mar 2003 05:19:47 -0500
Date: Mon, 24 Mar 2003 11:30:35 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jgarzik@pobox.com, rml@tech9.net, mj@ucw.cz, alan@redhat.com, pavel@ucw.cz,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-Id: <20030324113035.540cfd25.skraw@ithnet.com>
In-Reply-To: <1940000.1048460794@[10.10.2.4]>
References: <29100000.1048459104@[10.10.2.4]>
	<3E7E3AF0.6040107@pobox.com>
	<1940000.1048460794@[10.10.2.4]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003 15:06:35 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> > I agree that we are disagreeing about what should be mainline 2.4 :)

I guess this is the main reason why kernel-maintenance is organized
non-democratic (and has always been). Sometimes you just get nowhere if 5
brilliant people (_no_ sarcasm here) talk about at least 6 brilliant, but
completely different, ideas.

> > "People are shipping it, so it must be good" is the proverbial
> > road-to-hell-paved-with-good-intentions.
> 
> Mmmm ... not sure what that says about the vendor kernels ;-)

As we all know it just says everything.

> But I'm well aware that that's in disagreement with others ... having a
> separate "common-vendor" tree is probably the right thing to do.

dear Martin, dear Jeff, dear all,

_please_ be honest and realistic: we are talking about the problem of vendors
forking around yakr (Yet Another Kernel Release) and you really say "lets solve
it all with _another_ fork" ?? Come on, don't be silly (tm Linus).
Let's focus and not fork. There _are_ issues with 2.4, but they are getting
solved bit-by-bit. It would be faster of course if we all would concentrate on
the _mainline_ and not on yet-another patchlist, split-tree or whatever.

Another thing has already been talked about here, so lets talk real open about
it: some of us are living in the strong impression that Marcelo has problems
with the pure time working on maintaining. I do not know anything about the
backgrounds, but if this is really true, then let _me_ ask Conectiva if there
is a chance that he can do the maintaining full-time. I mean this is for sure
one of the interesting PR activities, too. After all those years it is still
true: there can be only one.
Of course this only makes sense if he still really wants to do that. _Me_
asking this because I am in no way related to any other distro, vendor or
Marcelo, just being the "linux-enthusiast from next-door" (with management
background ;-). 

JMHO
Stephan
