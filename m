Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSJTQi5>; Sun, 20 Oct 2002 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJTQi5>; Sun, 20 Oct 2002 12:38:57 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4281 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263215AbSJTQi5>; Sun, 20 Oct 2002 12:38:57 -0400
Date: Sun, 20 Oct 2002 10:44:58 -0600
Message-Id: <200210201644.g9KGiwh13964@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LARGE patch 23/124] sets sent over and over again Re: [PATCH]
	ext2/3 updates for 2.5.44 (1/11): Default mount options in superblock
In-Reply-To: <1035108575.3130.10.camel@localhost.localdomain>
References: <E183CUa-0007Yq-00@snap.thunk.org>
	<1035108575.3130.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
> I hereby politely ask EVERYONE who wants to (re)posts large patchsets,
> to at minimum try to follow something like the following politeness
> guidelines

<aol>
Agreed! The ext2/ext3/ACL/ext-attr and s390 patchkits are really bad
offenders (sorry, guys:-). This has been annoying me for a while too.
</aol>

I'd suggest that even the first sending of a patchkit should be a
single thread, so it can be deleted in one fell swoop for those who
don't have the time or the interest to read the patches.

I'd like to see the first message explain what the patchkit does, and
provide a diffstat for the entire patchkit.

As Russell suggested, having this scripted is probably a good idea. It
would also make it easy to add a 5 or 10 minute delay between sending
the introductory message and the patches. That helps people who don't
sort their mailboxes :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
