Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVBXWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVBXWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVBXWJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:09:56 -0500
Received: from smarthost1.sentex.ca ([64.7.153.18]:27409 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S262509AbVBXWJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:09:49 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Greg Folkert'" <greg@gregfolkert.net>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Greg's Decree! (was Re: Linus' decrees?)
Date: Thu, 24 Feb 2005 17:08:33 -0500
Organization: Connect Tech Inc.
Message-ID: <002201c51abd$712cf500$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1109280654.14960.5.camel@king.gregfolkert.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Folkert [mailto:greg@gregfolkert.net] 
> On Thu, 2005-02-24 at 15:03 -0500, Stuart MacDonald wrote:
> > Recently I ran across
> > 
> > http://groups.google.ca/groups?hl=en&lr=lang_en&safe=off&selm=
> > 1033074519.2698.5.
> > camel%40localhost.localdomain
> > 
> > Is there a collection point for Linus' decrees?
> > 
> > The LSB (http://www.linuxbase.org/) seems to be mostly involved with
> > how a distro is laid out, and not much to do with the kernel.
> 
> Okay, Linus decreed... oh yeah.
> Exactly what is wrong with the method anyway?
> You on Crack?

Uh, what? I'm not sure what you're trying to say with the above,
except that maybe you think I was implying that the
/lib/modules/`uname -r`/build method is somehow wrong. Which I wasn't,
and I'm not even sure how you'd come to that conclusion from my post.

And no, I'm not on crack.

> Make TONS-O-SENSE to state the obvious. IOW the statement was all meant
> to say *DO IT THIS WAY AND NO OTHER* as nobody else honors any other
> method.

The post I reference mentions that Linus once said that a standard
method to locate the source for a particular kernel would be to have
it at /lib/modules/`uname -r`/build. This seems to be a symlink for
vanilla kernels, and actual source for the FC3 installed kernels I
have handy.

I had not heard this before, and it turns out to be handy for me. In
the past I have also seen Linus state things like "binary drivers are
bad" and "drm is okay".

So what I'm wondering is, is there a location on the net where Linus'
statements about how the kernel is to be are collected? ie, Where the
above statements could all be found, with cites.

I'm thinking there's probably other info about the standard way of
doing things in regards to the kernel (all aspects thereof) that Linus
has put forth that might be handy for me to know, and I'm hoping that
there's a handy dandy collection that I can peruse.

I guess what I'm looking for is a collection of linux kernel policies.
Is there such a collection?

..Stu

