Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSJ3RBz>; Wed, 30 Oct 2002 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264746AbSJ3RBz>; Wed, 30 Oct 2002 12:01:55 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:14347 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S264745AbSJ3RBy>; Wed, 30 Oct 2002 12:01:54 -0500
Message-Id: <200210301708.g9UH8I509646@earth.colorado-research.com>
Content-Type: text/plain; charset=US-ASCII
From: Orion Poplawski <orion@colorado-research.com>
Organization: CoRA
To: Mitch Adair <mitch@theneteffect.com>
Subject: Re: Running linux-2.4.20-rc1 on Dell Dimension 4550
Date: Wed, 30 Oct 2002 10:08:17 -0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210300642.AAA32370@mako.theneteffect.com>
In-Reply-To: <200210300642.AAA32370@mako.theneteffect.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 11:42 pm, Mitch Adair wrote:
> > Thought I'd post some information about what I'm seeing running RH7.3
> > with kernel 2.4.20-rc1 on a brand new Dell Dimension 4550.  Currently
> > there are two problems with the machine:
> >
> > - When I swtich to a text console and back to the X screen, the machine
> > locks up (or at least the console does not respond anymore).
>
> you don't say the kernel, X, or hardware, but I've seen that personally
> with radeon 7500... that what you have?

Kernel is 2.4.20-rc1, X is 4.2.0-8 from RH.  The X log reports:

(--) Chipset ATI Rage 128 Pro ULTRA TF (AGP) found

Warnings/errors are:

(WW) R128(0): Can't determine panel dimensions, and none specified.
       Disabling programming of FP registers.

(EE) R128(0): No DFP detected

The Dell packing list reports: 32MB ATI RAGE ULTRA 4X AGP.

Probably should take this off linux-kernel....

- Orion
