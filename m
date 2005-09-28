Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVI1LhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVI1LhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVI1LhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:37:07 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:32106 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751252AbVI1LhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:37:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=w89bKB55aXVsJMTeoQHkhUWmBird+5Fzxww1sKgqPtuDeoaw2K//s7U6MKv8ZXhL72v93LUmERBiZrasGV4IC7FK7n6lcVvVttn3uW1d9fYH1f8RTOAwjRsAj4mvxJbNcWZaguXcmEE4yQRTjOipwBPSPTRS03e+N/Z2x+2b658=  ;
Message-ID: <20050928113703.65626.qmail@web31806.mail.mud.yahoo.com>
Date: Wed, 28 Sep 2005 04:37:03 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
To: Andre Hedrick <andre@linux-ide.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10509271604510.14637-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

--- Andre Hedrick <andre@linux-ide.org> wrote:
> From what I know from history and why I no longer maintain anything,
> (working to get sanity back) is the Maintainer defines direction while
> following a bigger picture.

Yes, and I think you'll agree with me, the Maintainer isn't/shouldn't
necessarily be the person "defining direction".  The reasons are
many but mostly:
  * Documentation/ManagingStyle document (valuable read),
That document _really_ says it _all_.  I suggest all developers, maintainers,
and corporate _management_ reading this thread to read it.

Why should the Maintainer be "defining direction"?  Is this some
religous cult where "Beaver knows best?" (punt intended!)
Or is this a theocratic society here at Linux SCSI? "Pi = 3" ;-)

The maintainership role is and has been _clearly_ defined!  For the
sake of eveyone else, take a look at 2.4 maintainer, 2.6 maintainer,
other subsystem maintainers: defined by example and in word.
So much unlike SCSI Core.

Another also great reason is:
  * Complete, utter and infinite _incompetence_ coupled with too much pride.
It hurts us all.

When it comes down to it SCSI Core is 20 years behind and thus Linux Storage
is 20 years behind.

> Help create a better lie by mapping into the design set forward by James
> and company.  If the goal of Adaptec is to have support then they need to

Yes, this is indeed a very valuable advice.  I hadn't ever looked at it
like that.

What I thought, albeit erroneously, mea culpa, is that Linux actually
_wanted_ to be "the storage OS of choice".  Now I see and realize that
due to neglected management, Linux has very little to do with _storage_.

Linux need to thank the mutitude of storage ignorant customers
willing to pay the buck, because it is _Linux_ (put gasping sound here).

Linux _can_ be the "storage OS of choice", but this will not happen
through neglect, or sheer incompetence coupled with lots of pride.

Back on topic: I'll try to keep up this "Linux storage lie" set forth
by the james-bottomleys of the Linux community.

> buckup and play be to rules at hand.  Remember, most people are open to
> new ideas and better models.  Propose one and you will find backing.

I never have found backing.  It is all in the archives of linux-scsi
mailing list.  What happens is that even if people like your idea
and write to you _privately_ to tell you that they like your
idea, somewhere in their email, they tell you not to cross-post
their message to the list because they have storage products which
need Linux.  The reason for this is that James Bottomley has established
this politics that if you don't agree to his antics, your patches are
never ever going in.  Why else do you think IBM-ers agree with him that
Linux SCSI doesn't need 64 bit LUNS?

_But_ I'm willing to try _again_.  So I'll be proposing something
later this morning.  (You know, all engineers are optimists.)

       Luben

