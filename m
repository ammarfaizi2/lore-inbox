Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTKFJdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTKFJdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:33:04 -0500
Received: from tarantel.rz.fh-muenchen.de ([129.187.244.239]:15614 "HELO
	mailserv.rz.fh-muenchen.de") by vger.kernel.org with SMTP
	id S263466AbTKFJdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:33:02 -0500
Date: Thu, 6 Nov 2003 10:36:21 +0100
From: Daniel Egger <degger@tarantel.rz.fh-muenchen.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Egger <degger@fhm.edu>, Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Re:No backlight control on PowerBook G4
Message-ID: <20031106103621.D18367@tarantel.rz.fh-muenchen.de>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca> <1067820334.692.38.camel@gaston> <1067878624.7695.15.camel@sonja> <1067896476.692.36.camel@gaston> <1067976347.945.4.camel@sonja> <1068078504.692.175.camel@gaston> <20031106090132.B18367@tarantel.rz.fh-muenchen.de> <1068107179.692.200.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2us
In-Reply-To: <1068107179.692.200.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 07:26:19PM +1100, Benjamin Herrenschmidt wrote:

> For PowerMac in general, you'd rather use my tree, at least until maybe
> around 2.6.1, and even then... Especially for such very new machine for
> which the proper support is only getting in now.

While your tree is about a mac can get I had several troubles in the past
on other architectures and unfortunately I have to run them as well. Since
bandwidth is not as cheap as one might think I do *not* have the ressources
to keep several trees up-to-date. 

However I'm diffing your tree against a recent Linus version right now and will
retry.

--
Servus,
       Daniel
