Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290422AbSA3SjH>; Wed, 30 Jan 2002 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290419AbSA3Shu>; Wed, 30 Jan 2002 13:37:50 -0500
Received: from [198.17.35.35] ([198.17.35.35]:51105 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S290418AbSA3SdH>;
	Wed, 30 Jan 2002 13:33:07 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2B2F@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Larry McVoy'" <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 10:33:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole point of the pristine tree is to give yourself a tree into 
> which you can import Linus patches.  If you start putting extra stuff
> in there you will get patch rejects.

or in the opposite direction : your changesets sent to linus have to be
patches against the pristine tree, not against your-working-tree-with-
several-patches-that-linus-doesn't-have.

(tying your response to Ingo into this one :)

it makes sense : any submitted patches should be against a known-clean
state, which means that the 'linear' element that people complain about
is actually bk enforcing some rather logical development practices.

but if linus isn't going to accept changesets (only patches) anyways,
then i guess it really doesn't matter :)

dana lacoste
ottawa, canada
