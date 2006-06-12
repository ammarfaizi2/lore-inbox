Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWFLUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWFLUHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWFLUHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:07:51 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42730 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932207AbWFLUHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:07:51 -0400
Date: Mon, 12 Jun 2006 13:06:48 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
In-reply-to: <20060612084012.GA7291@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0606121304580.11296@montezuma.fsmlabs.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
 <20060611072223.GA16150@flint.arm.linux.org.uk>
 <20060612083239.GA27502@mea-ext.zmailer.org>
 <20060612084012.GA7291@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Russell King wrote:

> On Mon, Jun 12, 2006 at 11:32:39AM +0300, Matti Aarnio wrote:
> > SPF is application level version of this type of source sanity
> > enforcement, and all that I intend to do is to publish that TXT
> > entry for VGER.  Analyzing SPF data in incoming SMTP reception
> > is a thing that I leave for latter phase  (how much latter,
> > I can't say yet.)
> 
> In which case I have no option but to ask - Zwane, please stop using
> my systems to forward your lkml email - Matti's proposed change will
> potentially break that setup.

Thanks for the heads up Russell, i'll come up with an alternative.

Cheers,
	Zwane

