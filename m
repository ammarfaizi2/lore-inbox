Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRHAIxa>; Wed, 1 Aug 2001 04:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbRHAIxU>; Wed, 1 Aug 2001 04:53:20 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:58375 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S265277AbRHAIxH>; Wed, 1 Aug 2001 04:53:07 -0400
From: bvermeul@devel.blackstar.nl
Date: Wed, 1 Aug 2001 10:55:56 +0200 (CEST)
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: Chris Vandomelen <chrisv@b0rked.dhs.org>, <linux-kernel@vger.kernel.org>
Subject: Re[6]: cannot copy files larger than 40 MB from CD
In-Reply-To: <200108010026.CAA1998572@mail.takas.lt>
Message-ID: <Pine.LNX.4.33.0108011054130.23193-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Nerijus Baliunas wrote:

> CV> > CV> gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
> CV> > CV> used for compiling kernels. (kgcc is egcs-1.1.2, I think.)
> CV> >
> CV> > As I remember Alan said recent 2.4 kernels should be compiled with gcc 2.95
> CV> > or 2.96 (preferably?).
> CV>
> CV> Everything that I've seen recommends egcs-1.1.2. The kernel documentation
> CV> (linux/Documentation/Changes) recommends that version of egcs, as do some
> CV> list messages around 12/00.
>
> Please read message which was posted a few minutes ago (in another thread).
> 2.4.7 even does not compile with egcs.

Sure it does. You just need a newer binutils. (I know, I've got a RH 6.2
box running with 2.4.7-ac3 and ext3 patches, compiled with egcs 1.1.2 and
the binutils from RH 7.1. It helps to correctly interpret the error
messages...)

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

