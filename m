Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWCNKrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWCNKrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCNKrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:47:10 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:37387 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932314AbWCNKrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:47:08 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <seanlkml@sympatico.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Tue, 14 Mar 2006 02:46:25 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEDIKLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <BAYC1-PASMTP053A190824D64AF757F3ADAEE10@CEZ.ICE>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 14 Mar 2006 02:42:51 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 14 Mar 2006 02:42:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 13 Mar 2006 13:57:40 -0800
> "David Schwartz" <davids@webmaster.com> wrote:

> > 	No, it does not. Copyright law only gives copyright owners
> > the right to
> > control the *creation* of derivative works. I very carefully worded my
> > statement above so that it would talk about precisely the right
> > people claim
> > they have and precisely the right they do not have.

> > 	In this case, the alleged derivative work is created under
> > first sale, as
> > part of normal use. It is impossible to normally use the 'kernel-devel'
> > package without creating derivative works, and under first
> > sale, normal use
> > (and anything required for normal use) cannot be burdened. Once the
> > derivative work is lawfully created, there is nothing in
> > copyright law that
> > requires the permission of the author of the original work to
> > distribute the
> > derived work to licensees of the original work.

> > 	The GPL gets around this by imposing requirements on the creation of
> > derivative works, under the assumption that you cannot get the right to
> > create a derivative work any other way. But this is false,
> > first sale grants
> > the right to normal use, and normal use includes anything necessary for
> > normal use. For a library or for the 'kernel-devel' package, normal use
> > requires the creation of derivative works.
> >

> So i buy a book; clearly the reason it's written in english is so
> that I can
> extend and alter it.

	How is that clear? The normal use of a book is to read it and think about
it. Extending and altering it is not only not the normal use but explicitly
protected under copyright law (as a sequel).

	While making a kernel module can be argued to be extending the kernel, I
don't think you can argue it's "altering" the kernel. I certainly would not
argue that you can produce an altered version of the kernel and distribute
it in binary only form.

> So I rip out the last chapter and replace
> it with one
> of my own.   Now _clearly_ i can distribute this new work around the world
> without any fear of being sued by the copyright holders because
> it's fair use.
> NOT!

	Again, your example fails because you are talking about distributing it to
people who do not lawfully acquire the original work. You notice I carefully
said "to licensees of the original work" and yet your example talks about
distribute to people who are not licensees of the original work.

	A better example might be if you and a friend each buy a copy of music. You
transpose it into a different key for your friend and then give him a copy
of the transposed work. There's a huge difference between giving that copy
to a licensee of the original work and giving it to someone who is not a
licensee of the original work. You can argue whether you could lawfully
transpose it in the first place, but assuming the creation is lawful, you
can certainly distribute it to other licensees of the original work. (No
court, AFAIK, has ever held otherwise and nothing in copyright law says
otherwise. Please correct me if I'm wrong.)

> Now before you try to argue that altering copyrighted source code is fair
> use but altering copyrighted books isn't; just stop.

	I wasn't talking about fair use. If you think I would argue fair use, you
really have no idea what I'm talking about. I'm talking about:

	1) First sale. That is, the right to the normal use of a lawfully-acquired
work, and

	2) The absence of a specific right under copyright to restrict the
distribution of lawfully-created derivative works.

	And who was ever talking about altering anything? Why would you think this
is about "altering" copyrighted source code? Making an application that uses
a library isn't about "altering" the library. Making a kernel module isn't
about "altering" the kernel. Perhaps you are replying on auto-pilot and not
reading what I'm actually writing. I am *NOT* talking about modifying a
GPL'd work and then distributing the modified work in binary form.

> Please leave this
> matter to the lawyers and off this list.

	If you want it off the list, don't reply or reply off the list. But if you
choose to reply with an argument, I have as much right to rebut it in a
given forum as you do to make it. How can a rebuttal of an argument be any
less on-topic than the argument?

	DS


