Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbSA3AaG>; Tue, 29 Jan 2002 19:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSA3A26>; Tue, 29 Jan 2002 19:28:58 -0500
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:56752 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S287163AbSA3A1j>;
	Tue, 29 Jan 2002 19:27:39 -0500
Date: Tue, 29 Jan 2002 17:27:38 -0700 (MST)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0201291719070.24557-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

> They are both maintainers. That doesn't mean that I necessarily work with
> every maintainer directly.
> 
> Or look at USB: I get the USB patches from Greg, and he gets them from
> various different people. Johannes Erdfelt is the maintainer for uhci.c,
> and he sends them to Greg, not to me.
> 
> Why? Because having hundreds of people emailing me _obviously_ doesn't
> scale. Never has, never will. It may work over short timeperiods wih lots
> of energy, but it obviously isn't a stable setup.

Linus,

That's fine, but there's a major problem with your scheme.  What happens
with all the stuff for which no one is listed in MAINTAINERS?  For example,
no one owns linux/Documentation.  As the person nominally in charge of
linux/Documentation/Changes, there's no one between me and you, period, let
alone anyone between me and you that you trust....  And I realize that you
don't consider documentation very important, but there are other segments of
the Linux source tree for which this breakdown in hierarchy is also true....

later,
chris

