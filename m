Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261261AbRERR2s>; Fri, 18 May 2001 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261255AbRERR2i>; Fri, 18 May 2001 13:28:38 -0400
Received: from ns.caldera.de ([212.34.180.1]:46210 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261246AbRERR2d>;
	Fri, 18 May 2001 13:28:33 -0400
Date: Fri, 18 May 2001 19:28:21 +0200
Message-Id: <200105181728.f4IHSLP19357@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: dalgoda@ix.netcom.com (Mike Castle)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010518101533.E10611@thune.mrc-home.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010518101533.E10611@thune.mrc-home.com> you wrote:
> On Fri, May 18, 2001 at 12:00:59PM -0400, John Cowan wrote:
>> Christoph Hellwig wrote:

[my voice was snipped here]

>> Yes, I should have limited myself to pre-egcs versions.
>
> Huh?
>
> It's been possible to have multiple versions of gcc installed for a very
> long time.  At least since 2.0 came out.
>
> Thu Dec 19 15:54:29 1991  K. Richard Pixley  (rich at cygnus.com)
>
>         * configure: added -V for version number option.

But with at least the combination of gcc2.7.2.x and egcs1.x it did not
work for me (and others).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
