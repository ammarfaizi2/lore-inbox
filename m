Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWGHT6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWGHT6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGHT6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:58:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7103 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030288AbWGHT6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:58:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Sunil Kumar" <devsku@gmail.com>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sat, 8 Jul 2006 21:58:48 +0200
User-Agent: KMail/1.9.3
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Bojan Smojver" <bojan@rexursive.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Avuton Olrich" <avuton@gmail.com>,
       "Olivier Galibert" <galibert@pobox.com>,
       "Jan Rychter" <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       "Nigel Cunningham" <ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz> <200607082125.12819.rjw@sisk.pl> <ce9ef0d90607081248n1f2fc79fw199b493f3ca6313@mail.gmail.com>
In-Reply-To: <ce9ef0d90607081248n1f2fc79fw199b493f3ca6313@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607082158.49013.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 21:48, Sunil Kumar wrote:
> >
> > Now there seem to be two possible ways to go:
> > 1) Drop the implementation that already is in the kernel and replace it
> > with
> > the out-of-the-tree one.
> > 2) Improve the one that already is in the kernel incrementally, possibly
> > merging some code from the out-of-the-tree implementation, so that it's as
> > feature-rich as the other one.
> >
> > Apparently 1) is what Nigel is trying to make happen and 2) is what I'd
> > like
> > to do.
> 
> Is that really true, Nigel, that you want 1)?
> 
> Is it really impossible to have the third possbility of both the
> implementations in kernel at the same time?

Well, I'm not totally against that, at least as far as -mm is concerned,
but I meant "in the long run".

Greetings,
Rafael
