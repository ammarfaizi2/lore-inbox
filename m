Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRGFRU5>; Fri, 6 Jul 2001 13:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266760AbRGFRUi>; Fri, 6 Jul 2001 13:20:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38668 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265754AbRGFRUc>; Fri, 6 Jul 2001 13:20:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, helgehaf@idb.hist.no (Helge Hafting)
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Date: Fri, 6 Jul 2001 14:42:04 +0200
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E15ITaa-0004Ei-00@the-village.bc.nu>
In-Reply-To: <E15ITaa-0004Ei-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0107061442040Q.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 13:16, Alan Cox wrote:
> > I am convinced.  I misunderstood, thinking there was a big change just
> > for
> > ACPI which I and many others don't use.  Thanks for clearing things up.
>
> It solves a few long standing arguments too - we can slap .config in it
> ending the long standing /proc/config argument without using any ram except
> when people care

The same for System.map

--
Daniel

