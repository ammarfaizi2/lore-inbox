Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVLFG3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLFG3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVLFG3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:29:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48568
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932432AbVLFG3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:29:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Tue, 6 Dec 2005 00:28:54 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <4394766A.8060803@pobox.com> <20051205172915.GK13985@lug-owl.de>
In-Reply-To: <20051205172915.GK13985@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512060028.55052.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 11:29, Jan-Benedict Glaw wrote:
> On Mon, 2005-12-05 12:18:34 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Arjan van de Ven wrote:
> > >Linux in a binary world
> >
> > You forgot the effect of binary-only on non-x86 arches...
>
> Um, let's write an binary emulator for those archs. It did work for
> Alphas executing i386 code, so it'd work for PPC, too :-)

Fabrice Bellard beat you to it, QEMU, and yes it's GPL.

Trying to bolt it to the kernel would deeply suck.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
