Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289231AbSA3PD0>; Wed, 30 Jan 2002 10:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289229AbSA3PDR>; Wed, 30 Jan 2002 10:03:17 -0500
Received: from [198.17.35.35] ([198.17.35.35]:49656 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S289135AbSA3PDB>;
	Wed, 30 Jan 2002 10:03:01 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2B2B@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Chris Ricker'" <kaboom@gatech.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: RE: ANOTHER modest proposal -- We need a documentation package
Date: Wed, 30 Jan 2002 07:03:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  For example,
> no one owns linux/Documentation.  As the person nominally in charge of
> linux/Documentation/Changes, there's no one between me and 
> you, period, let
> alone anyone between me and you that you trust....  And I 
> realize that you
> don't consider documentation very important, but there are 
> other segments of
> the Linux source tree for which this breakdown in hierarchy 
> is also true....

Here's an idea :
Take linux/Documentation and split it into a separate package.
that way Linus doesn't need to care about documentation, it can
be maintained separately.  Having documentation packages co-released
with the kernel, but separately maintained would fix this problem,
would it not?

Dana Lacoste
Ottawa, Canada
