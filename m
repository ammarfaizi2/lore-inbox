Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTLXGkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 01:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTLXGkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 01:40:05 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:52389 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263447AbTLXGkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 01:40:02 -0500
Subject: Re: 2.6.0ben1 + ieee1394 (snapshot from yesterdays svn repos) ->
	works
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@debian.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031223142404.GY6607@phunnypharm.org>
References: <1072162924.2803.462.camel@localhost>
	 <20031223142404.GY6607@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1072247385.739.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Dec 2003 17:39:29 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-24 at 01:24, Ben Collins wrote:
> On Tue, Dec 23, 2003 at 08:02:04AM +0100, Soeren Sonnenburg wrote:
> > Hi!
> > 
> > I just wanted to send kudos, as this version seems to be the first one
> > which does not generate a kernel panik just from the very start. It was
> > also possible to transfer ~20GB (firewire attached ide-hd) via the sbp2
> > module and then removing the sbp2/ohci1394/ieee1394 module several times
> > without it oopsing (that was enough last time I checked to generate a
> > kernel panik!)
> 
> Thanks for the feedback.

I'm merging 1394 trunk into my tree, will be there for -ben2

Ben.


