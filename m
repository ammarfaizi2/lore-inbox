Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWBJCu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWBJCu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 21:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWBJCu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 21:50:56 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:13504 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751015AbWBJCu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 21:50:56 -0500
Date: Fri, 10 Feb 2006 03:50:51 +0100
From: Voluspa <lista1@telia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
 hackers.
Message-Id: <20060210035051.55dbb74a.lista1@telia.com>
In-Reply-To: <20060209233233.GB23971@kroah.com>
References: <20060210000101.2f028801.lista1@telia.com>
	<20060209233233.GB23971@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 15:32:33 -0800 Greg KH wrote:
> On Fri, Feb 10, 2006 at 12:01:01AM +0100, Voluspa wrote:
> > 
> > Booted 2.6.16-rc2 on my AMD x86_64 notebook and saw something new in the
> > log (different from 2.6.15):
> 
> So, 2.6.16-rc2 works just fine, with out your reversal of that one
> patch?

Eh, I bundled two issues in my rant. 1) nsxfeval, which the ACPI guys
have confirmed is pure noise and can be forgotten. 2) "PCI: Failed to
allocate mem resource" which has been there since the commit I pointed
to, and never has effected the machine negatively (as far as I can tell).
So yes, 2.6.16-rc2 seems fine, and I don't patch it for that PCI thing.
It's just that the message is present and will worry people 'forever'
if nothing is done.

There is another issue, but it's not a regression. I'll file a
bugzilla for that in a couple of days. Or a week...

> > "1) Silence is _not_ golden."
> > 
> > Please, we the users breathe and bleed just like you do.
> 
> Sorry, and like you, we are human and drop things on the floor all the
> time.  Sorry for not following up on this before.
> 
> Persistance is a good trait to have when dealing with overworked kernel
> developers :)

Yeah, I know, sorry if I jabbed too hard. I was caught up in a sadness for
anyone who's mail is ignored. There is a form of humiliation when that
happens on a high profile list like lkml or other kernel related lists.
A mirror of the defeat can be found on a small server in Korpilombolo for
the next two decades at least.

But I must say that during the years that I've read lkml, it _feels_ as if
the reply-rate has improved significantly. The list is not as terrifying as
it used to be.

Mvh
Mats Johannesson
--
