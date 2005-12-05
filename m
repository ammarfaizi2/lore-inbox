Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVLERRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVLERRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVLERRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:17:16 -0500
Received: from unthought.net ([212.97.129.88]:41742 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751384AbVLERRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:17:14 -0500
Date: Mon, 5 Dec 2005 18:17:13 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205171713.GC4179@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <greg@kroah.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051204170049.GA4179@unthought.net> <20051204223931.GA8914@kroah.com> <20051205151753.GB4179@unthought.net> <84144f020512050744l3cc8289dh9a34c6f60311b6aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020512050744l3cc8289dh9a34c6f60311b6aa@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 05:44:08PM +0200, Pekka Enberg wrote:
> Hi,
> 
> On Sun, Dec 04, 2005 at 02:39:31PM -0800, Greg KH wrote:
> > > Have you filed a but at bugzilla.kernel.org about this?  If not, how do
> > > you expect it to get fixed?
> 
> On 12/5/05, Jakob Oestergaard <jakob@unthought.net> wrote:
> > I don't expect to get it fixed. It's futile. It can get fixed in one
> > version and broken two days later, and it seems the attitude is that
> > that is just fine.
> 
> I don't think anyone breaks things on purpose.

Of course not, silly :)

But there's a difference between having a tree where you fix bugs and
having a tree where you are very lax about major changes. By including
major changes you (knowingly or not) risk breaking things, and things do
break regularly.

> Please feel free to
> report the bug as many times as necessary to get it fixed.

Thank you :)

If it did not occur to you, then I was never in doubt of this. I tried
to point out a problem in this approach - namely, that you will never
end up with a stable tree if major changes (read; new bugs) go in as
fast as old bugs are squashed.

You do get a tree that is evolving very quickly, and which is somewhat
stable for most purposes. Whether or not that is good enough for
everyone, was pretty much the topic of this thread as I understand it.

> You
> shouldn't be complaining if you're not doing your part.

I'm not complaining.  I'm voicing my oppinion in a thread that discusses
whether or not it would be a good idea to try and produce a stable tree.

I think it would be a good idea, and you're free to disagree.

Please read the thread if you're in doubt of the context of my comments  :)

-- 

 / jakob

