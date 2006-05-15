Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWEOXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWEOXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWEOXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:45:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750804AbWEOXpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:45:08 -0400
Message-ID: <44691280.9040600@garzik.org>
Date: Mon, 15 May 2006 19:45:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <1147736327.26686.224.camel@localhost.localdomain> <20060515234743.GD4699@animx.eu.org>
In-Reply-To: <20060515234743.GD4699@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Alan Cox wrote:
>> On Llu, 2006-05-15 at 19:02 -0400, Wakko Warner wrote:
>>> How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
>>> blow the hard drive away if I want to.
>> Give the patch on zeniv.linux.org.uk/~alan/IDE a go in that case and let
>> me know how it behaves.
> 
> I noticed one hunk failed with 2.6.17-rc4 when using
> patch-2.6.17-rc3-ide2.gz
> 
> It was only the version string so I should be ok.  As I said, if it blows up
> on me, that's ok.
> 
> I attempted to patch Jeff's libata1 over top of this, it failed miserably.
> 
> When I patched Jeff's libata1 over 2.6.17-rc4, it was ok, except for 2
> files:

oh, its almost certain the patches will conflict.  My suggestion was 
more of a reference-<here>-if-things-break.

	Jeff



