Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUHZA6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUHZA6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUHZA6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:58:02 -0400
Received: from berrymount.xs4all.nl ([82.92.47.16]:30304 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S266538AbUHZAzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:55:51 -0400
Date: Thu, 26 Aug 2004 02:55:45 +0200
From: Rob van Nieuwkerk <robn@berrymount.nl>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-Id: <20040826025545.716b6c59.robn@berrymount.nl>
In-Reply-To: <200408250058.24845@smcc.demon.nl>
References: <1092793392.17286.75.camel@localhost>
	<1092845135.8044.22.camel@localhost>
	<20040823221028.GB4694@kroah.com>
	<200408250058.24845@smcc.demon.nl>
Organization: Berrymount Automation B.V.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-URL: http://www.berrymount.nl/
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 00:58:24 +0200
"Nemosoft Unv." <nemosoft@smcc.demon.nl> wrote:

Hi Nemosoft,

> Actually, I've got a little surprise for you. The NDA I signed with Philips 
> has already expired a year ago. Yet, I didn't just throw the decompressor 
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> code on the Internet. First, there could still be legal remedies since the 
> cams are still in production to this very day. Second, that NDA was signed 
> on a basis of trust and I do not want to lose that trust. I'm looking at 
> the bigger picture here: if we (Linux developers) can show we are 
> trustworthy, we may be able to get better support from hardware 
> manufacturers now and in the future (and really, that's what the kernel is 
> for 75% about ....) I'm still in contact with Philips and who knows, maybe 
> we can get all the source opened up...

Apparently Philips clearly indicated that disclosure would be fine with
them on this date (one year ago !!!!).  If they felt otherwise they
would have chosen a different date !

You don't mention any request or presure from Philips to not disclose.
So I assume that the only reason for you not to release the source is
some personal agenda.

The Philips cams are very good.  But for many real-life applications
they are useless without the binary-only decompressor module under Linux.

There are some severe bugs in either your Philips webcam driver, the
USB stack or the combination of both, resulting in a "dead" camera
within a second of use in some situations.  This can only be fixed by
a power cycle  (reported to you several times btw).

Not having the complete source available makes it unlikely that these
problems will be solved (nothing improved wrt this the last years).

I use 1000 Philips webcams in a product.  We are evaluating camera's for
a 2nd generation product of which several thousands more may be built.
Having the source for the driver available would certainly improve
chances that I'll use the Philips cams again.

Maybe Philips isn't impressed by thousands directly because they think
in hundreds of thousands.  But OTOH it may be an indication to them that
there is serious interest for a complete opensource Linux driver for
their nice webcam.

If you *do* notice some unhappy feelings within Philips about opensourcing
the decompressor, let me know: maybe it helps if I talk to them.

Please consider opening the source !

	greetings,
	Rob van Nieuwkerk
