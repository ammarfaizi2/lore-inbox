Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVKNVPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVKNVPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKNVPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:15:35 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19869 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932130AbVKNVPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:15:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 22:16:16 +0100
User-Agent: KMail/1.8.3
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <Pine.LNX.4.64.0511141116180.3263@g5.osdl.org> <200511142028.35448.mbuesch@freenet.de>
In-Reply-To: <200511142028.35448.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511142216.16806.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 14 of November 2005 20:28, Michael Buesch wrote:
> On Monday 14 November 2005 20:17, you wrote:
> > 
> > On Mon, 14 Nov 2005, Arjan van de Ven wrote:
> > > 
> > > there now is a specification for the broadcom wireless, and a driver is
> > > being written right now to that specification; and it seems to be
> > > getting along quite well (it's not ready for primetime use yet but at
> > > least they can send and receive stuff, which is probably the hardest
> > > part)
> > 
> > Goodie. With Broadcom and Intel on-board, we should have most of the 
> > market covered in wireless, and ndiswrappers really should be less of an 
> > argument (it was never an argument for me personally, but for others..). 
> 
> I really hope we get this thing usable in a few weeks.
> Looks good so far... .

Great!

> However, I did not test the broadcom driver on 4k-stacks,
> as I only have a G4 with a broadcom card. ;) But I do not expect any problems.

If you want someone to test it on x86-64, I think I can do that.

Greetings,
Rafael
