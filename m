Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFTPfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFTPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:35:48 -0400
Received: from windsormachine.com ([206.48.122.28]:46599 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263185AbTFTPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:35:47 -0400
Date: Fri, 20 Jun 2003 11:49:41 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Arnaud Ligot <spyroux@freegates.be>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: xircom card bus with 2.4.20 link trouble
In-Reply-To: <1056119306.6727.27.camel@portable>
Message-ID: <Pine.LNX.4.33.0306201147220.15589-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2003, Arnaud Ligot wrote:

> the card works with 2.4.20 nice and works if you set an ip address with
> the 2.4.21

7m33s+23m29s+6m58s+35s minutes and seconds later, I have a working 2.4.21

PCMCIA Card came up just fine, cardbus continues to refuse to work.

Now if only DMA mode would work on the Opti 621 chipset inside this
Omnibook 5500/5700 hybrid laptop :)  Then it wouldn't take 38 minutes to
compile.  I knew I should have done this on the p4/2.53 that sits right
next to it!

But anyways, that's the way it goes

Mike

