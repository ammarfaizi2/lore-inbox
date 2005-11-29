Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVK2WBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVK2WBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVK2WBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:01:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:3759 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964777AbVK2WBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:01:33 -0500
Subject: Re: [PATCH][RFC][2.6.15-rc3] snd_powermac: Add ID for Spring 2005
	17" Powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <E45E8695-5551-4297-9424-4BDC46DE28B6@mac.com>
References: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com>
	 <1133298593.16726.9.camel@gaston>
	 <E45E8695-5551-4297-9424-4BDC46DE28B6@mac.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 08:55:21 +1100
Message-Id: <1133301322.16726.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 16:35 -0500, Kyle Moffett wrote:
> On Nov 29, 2005, at 16:09, Benjamin Herrenschmidt wrote:
> > It's a different chip but heh, Toonie might work very basically  
> > (Toonie is basically a non-configurable codec).
> >
> > Anyway, what is needed is a rewrite of that driver from scratch  
> > with a more flexible architecture to deal with the multiple codecs  
> > & busses.
> 
> I might have some time to tinker, is there any place I can get specs  
> on the various chips from?  I know there's probably something in the  
> Darwin sources, but I'm completely unfamiliar with those, so I'm  
> interested in any advice you can offer.

Bits in Darwin yes, bits on the  various vendor web sites... I actually
have specs for almost all of the chips used in the recent machines;

I strongly suggest you first spend a few days digging through Darwin
sources to fully grasp the extent of the problem though :)

Ben.


